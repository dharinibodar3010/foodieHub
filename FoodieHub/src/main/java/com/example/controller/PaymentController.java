// package com.example.controller;
// 
// import java.util.Date;
// 
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.*;
// 
// import com.example.entity.Order;
// import com.example.service.OrderService;
// 
// // Disabled to resolve ambiguous mapping error with OrderController
// // @Controller
// public class PaymentController {
// 
// 	// @Autowired
// 	// private OrderService orderService;
// 
// 	// // Payment Page Open
// 	// @GetMapping("/payment")
// 	// public String paymentPage() {
// 	// 	return "user/payment";
// 	// }
// 
// 	// // Payment Success (COD / Razorpay Demo)
// 	// @PostMapping("/payment")
// 	// public String payment(@RequestParam("paymentMode") String paymentMode,
// 	// 		@RequestParam("totalAmount") double totalAmount, Model model) {
// 
// 	// 	Order order = new Order();
// 
// 	// 	order.setPaymentMode(paymentMode);
// 	// 	order.setTotalAmount(totalAmount);
// 	// 	order.setStatus("Order Placed");
// 	// 	order.setOrderDate(new Date());
// 
// 	// 	// Demo Project હોવાથી User set કર્યો નથી
// 	// 	// Login પછી Session માંથી User set કરી શકશો.
// 
// 	// 	orderService.saveOrder(order);
// 
// 	// 	model.addAttribute("paymentMode", paymentMode);
// 	// 	model.addAttribute("amount", totalAmount);
// 	// 	model.addAttribute("message", "Payment Successful");
// 
// 	// 	return "user/order-success";
// 	// }
// 
// }