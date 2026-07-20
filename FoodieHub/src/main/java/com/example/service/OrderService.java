package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Order;
import com.example.repository.OrderRepository;

@Service
public class OrderService {

	@Autowired
	private OrderRepository orderRepository;

	// Place Order

	public Order saveOrder(Order order) {

		return orderRepository.save(order);

	}

	// All Orders

	public List<Order> getAllOrders() {

		return orderRepository.findAll();

	}

	// User Orders

	public List<Order> getUserOrders(Long userId) {

		return orderRepository.findByUserId(userId);

	}

	// Update Order Status

	public Order updateOrder(Order order) {

		return orderRepository.save(order);

	}

	public Order getOrderById(Long id) {
		return orderRepository.findById(id).orElse(null);
	}

	// Delete Order

	public void deleteOrder(Long id) {

		orderRepository.deleteById(id);

	}

}