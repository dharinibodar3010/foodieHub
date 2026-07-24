package com.example.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

import com.example.entity.Cart;
import com.example.entity.Order;
import com.example.entity.User;
import com.example.service.CartService;
import com.example.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	private CartService cartService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private com.example.service.UserService userService;

	@Value("${razorpay.api.key}")
	private String razorpayApiKey;

	@GetMapping("/checkout")
	public String checkout(@RequestParam(required = false) String coupon, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		List<Cart> cartItems = cartService.getUserCart(user.getId());
		if (cartItems.isEmpty()) return "redirect:/cart";

		double totalAmount = 0;
		for (Cart cart : cartItems) {
			totalAmount += cart.getProduct().getPrice() * cart.getQuantity();
		}
		
		double tax = Math.round(totalAmount * 0.05);
		double discount = 0;
		if ("FOODIE50".equalsIgnoreCase(coupon)) {
			discount = Math.round(totalAmount * 0.5);
		}
		
		model.addAttribute("cartItems", cartItems);
		model.addAttribute("subtotal", totalAmount);
		model.addAttribute("tax", tax);
		model.addAttribute("discount", discount);
		model.addAttribute("totalAmount", totalAmount + tax - discount);
		model.addAttribute("razorpayKey", razorpayApiKey);
		
		return "user/checkout";
	}

	@Autowired
	private com.example.repository.OrderItemRepository orderItemRepository;

	@PostMapping("/place-order")
	public String placeOrder(@RequestParam double totalAmount, @RequestParam String address, @RequestParam String deliveryTime, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		// Update user address if they changed it during checkout
		if (address != null && !address.trim().isEmpty() && !address.equals(user.getAddress())) {
			user.setAddress(address);
			// Fetch the user from DB to update
			com.example.entity.User existingUser = userService.login(user.getEmail(), user.getPassword());
			if (existingUser != null) {
				existingUser.setAddress(address);
				userService.saveUser(existingUser);
				session.setAttribute("user", existingUser);
			}
		}

		List<Cart> cartItems = cartService.getUserCart(user.getId());
		if (cartItems.isEmpty()) return "redirect:/cart";

		Order order = new Order();
		order.setUser(user);
		order.setOrderDate(new Date());
		order.setTotalAmount(totalAmount);
		order.setStatus("Pending Payment");
		order.setDeliveryTime(deliveryTime);
		orderService.saveOrder(order);
		
		// Save order items
		for (Cart cart : cartItems) {
			com.example.entity.OrderItem orderItem = new com.example.entity.OrderItem();
			orderItem.setOrder(order);
			orderItem.setProduct(cart.getProduct());
			orderItem.setQuantity(cart.getQuantity());
			orderItem.setPrice(cart.getProduct().getPrice());
			orderItemRepository.save(orderItem);
		}

		// ✅ Do NOT clear cart here — clear only after successful payment
		// Cart will be cleared in PaymentController after payment confirmed

		return "redirect:/payment?orderId=" + order.getId();
	}

	@GetMapping("/orders")
	public String orders(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";
		
		List<Order> orders = orderService.getAllOrders().stream()
			.filter(o -> o.getUser().getId().equals(user.getId()))
			.toList();
		
		model.addAttribute("orders", orders);
		return "user/my-orders";
	}
}