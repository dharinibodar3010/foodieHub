package com.example.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Order;
import com.example.entity.Payment;
import com.example.repository.PaymentRepository;

@Service
public class PaymentService {

	@Autowired
	private PaymentRepository paymentRepository;

	public Payment processPayment(Order order, String paymentMode, String transactionId, double amount) {
		Payment payment = new Payment();
		payment.setOrder(order);
		payment.setPaymentMode(paymentMode);
		payment.setTransactionId(transactionId);
		payment.setAmount(amount);
		payment.setStatus("Success");
		payment.setPaymentDate(new Date());

		return paymentRepository.save(payment);
	}

	public Payment getPaymentByOrderId(Long orderId) {
		return paymentRepository.findByOrderId(orderId);
	}
}
