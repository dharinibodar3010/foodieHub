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

	@org.springframework.beans.factory.annotation.Value("${foodiehub.upload.dir}")
	private String uploadDir;

	@GetMapping("/")
	public String home(Model model) {
		java.util.List<com.example.entity.Product> allProducts = productService.getAllProducts();
		java.util.List<com.example.entity.Product> featuredProducts = allProducts.size() > 10 ? allProducts.subList(0, 10) : allProducts;
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

	@GetMapping("/forgot-password")
	public String forgotPasswordPage() {
		return "user/forgot-password";
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

	@Autowired
	private com.example.service.EmailService emailService;
	
	@Autowired
	private com.example.repository.NewsletterRepository newsletterRepository;

	@PostMapping("/subscribe-newsletter")
	@ResponseBody
	public String subscribeNewsletter(@RequestParam String email) {
		try {
			if (newsletterRepository.findByEmail(email) == null) {
				newsletterRepository.save(new com.example.entity.Newsletter(email));
			}
			
			String subject = "Welcome to FoodieHub Newsletter! 🍕";
			String body = "Hello Foodie,\n\n"
					+ "Thank you for subscribing to the FoodieHub Newsletter! \n"
					+ "We are thrilled to have you with us.\n\n"
					+ "You will now be the first to receive our exclusive discounts, secret promo codes, and updates about mouth-watering new dishes.\n\n"
					+ "Stay hungry, stay happy!\n"
					+ "- The FoodieHub Team";
			
			emailService.sendEmail(email, subject, body);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
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
			existingUser.setGender(user.getGender());
			if (user.getPassword() != null && !user.getPassword().isEmpty()) {
				existingUser.setPassword(user.getPassword());
			}

			if (!imageFile.isEmpty()) {
				try {
					String fileName = imageFile.getOriginalFilename();
					java.io.File dir = new java.io.File(uploadDir);
					if (!dir.exists()) dir.mkdirs();
					java.nio.file.Path imagePath = java.nio.file.Paths.get(uploadDir + "/" + fileName);
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

		return "redirect:/profile";
	}

	@GetMapping("/logout")
	public String logout(jakarta.servlet.http.HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	@PostMapping("/deleteProfilePhoto")
	@ResponseBody
	public String deleteProfilePhoto(jakarta.servlet.http.HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) return "error";
		try {
			User existingUser = userService.getUserById(sessionUser.getId());
			if (existingUser != null) {
				// Optionally delete the file
				if (existingUser.getProfileImage() != null) {
					java.io.File imgFile = new java.io.File(uploadDir + "/" + existingUser.getProfileImage());
					if (imgFile.exists()) imgFile.delete();
				}
				existingUser.setProfileImage(null);
				userService.saveUser(existingUser);
				session.setAttribute("user", existingUser);
			}
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}