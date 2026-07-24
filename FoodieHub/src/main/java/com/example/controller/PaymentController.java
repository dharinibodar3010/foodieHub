package com.example.controller;

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
import com.example.entity.Payment;
import com.example.entity.User;
import com.example.service.CartService;
import com.example.service.OrderService;
import com.example.service.PaymentService;

import java.util.List;

@Controller
public class PaymentController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private CartService cartService;

	@Autowired
	private com.example.service.UserService userService;

	@Value("${razorpay.api.key}")
	private String razorpayApiKey;

	@GetMapping("/payment")
	public String showPaymentPage(@RequestParam Long orderId, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		Order order = orderService.getOrderById(orderId);
		if (order == null || !order.getUser().getId().equals(user.getId())) {
			return "redirect:/orders";
		}

		if (!"Pending Payment".equals(order.getStatus())) {
			return "redirect:/orders";
		}

		model.addAttribute("order", order);
		model.addAttribute("razorpayKey", razorpayApiKey);

		return "user/payment";
	}

	@PostMapping("/process-payment")
	public String processPayment(
			@RequestParam Long orderId,
			@RequestParam String paymentMode,
			@RequestParam(required = false) String transactionId,
			HttpSession session, Model model) {

		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		Order order = orderService.getOrderById(orderId);
		if (order == null || !order.getUser().getId().equals(user.getId())) {
			return "redirect:/orders";
		}

		// Save Payment (add 5 Rs for COD)
		double finalAmount = order.getTotalAmount();
		if ("Cash on Delivery".equals(paymentMode)) {
			finalAmount += 5.0;
			order.setTotalAmount(finalAmount); // Update order total
		}
		
		Payment payment = paymentService.processPayment(order, paymentMode, transactionId, finalAmount);

		// Update Order Status
		order.setStatus("Order Placed");
		order.setPayment(payment);
		orderService.saveOrder(order);

		// Clear cart ONLY after successful payment
		List<Cart> cartItems = cartService.getUserCart(user.getId());
		if (!cartItems.isEmpty()) {
			cartService.deleteAllCarts(cartItems);
		}

		String pendingCoupon = (String) session.getAttribute("pendingCoupon_" + orderId);
		if ("FOODIE50".equals(pendingCoupon)) {
			com.example.entity.User existingUser = (com.example.entity.User) session.getAttribute("user");
			existingUser.setUsedWelcomeCoupon(true);
			userService.saveUser(existingUser);
			session.removeAttribute("pendingCoupon_" + orderId);
		}

		model.addAttribute("paymentMode", paymentMode);
		model.addAttribute("amount", payment.getAmount());
		model.addAttribute("message", "Payment Successful");
		model.addAttribute("orderId", order.getId());
		model.addAttribute("orderStatus", order.getStatus());

		return "user/order-success";
	}

	// Payment cancelled — mark order Cancelled, cart stays intact
	@PostMapping("/cancel-payment")
	public String cancelPayment(@RequestParam Long orderId, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		Order order = orderService.getOrderById(orderId);
		if (order != null && order.getUser().getId().equals(user.getId())
				&& "Pending Payment".equals(order.getStatus())) {
			order.setStatus("Cancelled");
			orderService.saveOrder(order);
		}

		// Cart is NOT touched — items remain in cart
		return "redirect:/cart";
	}
}
