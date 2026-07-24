package com.example.restcontroller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.entity.Order;
import com.example.entity.Payment;
import com.example.repository.OrderRepository;
import com.example.repository.PaymentRepository;

@RestController
@RequestMapping("/api/orders")
public class OrderRestController {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @GetMapping
    public ResponseEntity<List<Order>> getAllOrders() {
        return ResponseEntity.ok(orderRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        return orderRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Dummy place order endpoint
    @PostMapping("/place")
    public ResponseEntity<?> placeOrder(@RequestBody Order order) {
        order.setOrderDate(new Date());
        order.setStatus("Order Placed");
        
        if (order.getItems() != null) {
            order.getItems().forEach(item -> item.setOrder(order));
        }
        
        Order savedOrder = orderRepository.save(order);

        // Save Payment - use COD or Online Payment
        Payment payment = new Payment();
        payment.setAmount(savedOrder.getTotalAmount());
        payment.setStatus("Success");
        payment.setPaymentDate(new Date());
        payment.setOrder(savedOrder);
        
        // Check if COD was requested
        if (savedOrder.getStatus() != null && savedOrder.getStatus().toLowerCase().contains("cod")) {
            payment.setPaymentMode("Cash on Delivery");
            payment.setTransactionId("COD");
        } else {
            payment.setPaymentMode("Online Payment");
            payment.setTransactionId("TXN_" + System.currentTimeMillis());
        }
        
        paymentRepository.save(payment);
        savedOrder.setPayment(payment);
        
        return ResponseEntity.ok(Map.of(
            "message", "Order placed successfully",
            "orderId", savedOrder.getId()
        ));
    }
}
