package com.example.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

	@GetMapping("/checkout")
	public String checkout(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		List<Cart> cartItems = cartService.getUserCart(user.getId());
		if (cartItems.isEmpty()) return "redirect:/cart";

		double totalAmount = 0;
		for (Cart cart : cartItems) {
			totalAmount += cart.getProduct().getPrice() * cart.getQuantity();
		}
		
		double tax = totalAmount * 0.05;
		
		model.addAttribute("cartItems", cartItems);
		model.addAttribute("subtotal", totalAmount);
		model.addAttribute("tax", tax);
		model.addAttribute("totalAmount", totalAmount + tax);
		
		return "user/checkout";
	}

	@Autowired
	private com.example.repository.OrderItemRepository orderItemRepository;

	@PostMapping("/payment")
	public String payment(@RequestParam String paymentMode, @RequestParam double totalAmount, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		List<Cart> cartItems = cartService.getUserCart(user.getId());
		if (cartItems.isEmpty()) return "redirect:/cart";

		Order order = new Order();
		order.setUser(user);
		order.setOrderDate(new Date());
		order.setPaymentMode(paymentMode);
		order.setTotalAmount(totalAmount);
		order.setStatus("Placed");
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

		// Clear cart after placing order
		for (Cart cart : cartItems) {
			cartService.deleteCart(cart.getId());
		}

		model.addAttribute("paymentMode", paymentMode);
		model.addAttribute("amount", totalAmount);
		model.addAttribute("message", "Payment Successful");
		model.addAttribute("orderId", order.getId());

		return "user/order-success";
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