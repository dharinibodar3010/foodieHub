package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

import com.example.entity.Cart;
import com.example.entity.Product;
import com.example.entity.User;
import com.example.service.CartService;
import com.example.service.ProductService;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductService productService;

	@GetMapping("/cart")
	public String cart(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		List<Cart> cartItems = cartService.getUserCart(user.getId());
		model.addAttribute("cartItems", cartItems);
		return "user/cart";
	}

	@PostMapping("/addToCart")
	public String addToCart(@RequestParam Long productId, @RequestParam(defaultValue = "1") int quantity, HttpSession session, jakarta.servlet.http.HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		Product product = productService.getProductById(productId);
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(product);
		cart.setQuantity(quantity);
		cartService.addCart(cart);
		
		String referer = request.getHeader("Referer");
		return "redirect:" + (referer != null ? referer : "/products");
	}

	@PostMapping("/updateCartQty")
	@ResponseBody
	public String updateCartQty(@RequestParam Long cartId, @RequestParam int quantity, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "error";
		
		Cart cart = cartService.getUserCart(user.getId()).stream().filter(c -> c.getId().equals(cartId)).findFirst().orElse(null);
		if (cart != null) {
			cart.setQuantity(quantity);
			cartService.updateCart(cart);
			return "success";
		}
		return "error";
	}

	@GetMapping("/removeCart/{id}")
	public String removeCart(@PathVariable Long id, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			cartService.deleteCart(id);
		}
		return "redirect:/cart";
	}

	@GetMapping("/api/cart/count")
	@ResponseBody
	public String getCartCount(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			List<Cart> cartItems = cartService.getUserCart(user.getId());
			return String.valueOf(cartItems.size());
		}
		return "0";
	}
}