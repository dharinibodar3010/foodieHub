package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.entity.User;
import com.example.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private com.example.service.ProductService productService;

	@Autowired
	private com.example.repository.CategoryRepository categoryRepository;

	@GetMapping("/")
	public String home(Model model) {
		java.util.List<com.example.entity.Product> allProducts = productService.getAllProducts();
		java.util.List<com.example.entity.Product> featuredProducts = allProducts.size() > 3 ? allProducts.subList(0, 3) : allProducts;
		model.addAttribute("featuredProducts", featuredProducts);
		model.addAttribute("categories", categoryRepository.findAll());
		return "user/index";
	}

	@GetMapping("/register")
	public String registerPage(Model model) {
		model.addAttribute("user", new User());
		return "user/register";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute User user) {
		userService.saveUser(user);
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String loginPage() {
		return "user/login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, Model model, jakarta.servlet.http.HttpSession session) {

		User user = userService.login(email, password);

		if (user != null) {
			session.setAttribute("user", user);
			return "redirect:/products";
		} else {
			model.addAttribute("msg", "Invalid Email or Password");
			return "user/login";
		}
	}

	@GetMapping("/users")
	public String users(Model model) {
		model.addAttribute("list", userService.getAllUsers());
		return "admin/users";
	}

	@GetMapping("/profile")
	public String profile(jakarta.servlet.http.HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		model.addAttribute("user", user);
		return "user/profile";
	}

	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute User user, @RequestParam("imageFile") org.springframework.web.multipart.MultipartFile imageFile, jakarta.servlet.http.HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			return "redirect:/login";
		}

		User existingUser = userService.login(sessionUser.getEmail(), sessionUser.getPassword());
		if (existingUser != null) {
			existingUser.setName(user.getName());
			existingUser.setEmail(user.getEmail());
			existingUser.setMobile(user.getMobile());
			existingUser.setAddress(user.getAddress());
			if (user.getPassword() != null && !user.getPassword().isEmpty()) {
				existingUser.setPassword(user.getPassword());
			}

			if (!imageFile.isEmpty()) {
				try {
					String fileName = imageFile.getOriginalFilename();
					java.nio.file.Path imagePath = java.nio.file.Paths.get("src/main/webapp/images/" + fileName);
					java.nio.file.Files.write(imagePath, imageFile.getBytes());
					existingUser.setProfileImage(fileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			userService.saveUser(existingUser);
			session.setAttribute("user", existingUser);
			redirectAttributes.addFlashAttribute("msg", "Profile updated successfully!");
		}

		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logout(jakarta.servlet.http.HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}