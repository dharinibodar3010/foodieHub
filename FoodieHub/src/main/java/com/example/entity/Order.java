package com.example.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private double totalAmount;

	private String paymentMode;

	private String status;

	private Date orderDate;

	@ManyToOne
	private User user;

	@jakarta.persistence.OneToMany(mappedBy = "order", cascade = jakarta.persistence.CascadeType.ALL, fetch = jakarta.persistence.FetchType.EAGER)
	private java.util.List<OrderItem> items;

	public Order() {

	}

	public Order(Long id, double totalAmount, String paymentMode, String status, Date orderDate, User user) {

		this.id = id;
		this.totalAmount = totalAmount;
		this.paymentMode = paymentMode;
		this.status = status;
		this.orderDate = orderDate;
		this.user = user;

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public java.util.List<OrderItem> getItems() {
		return items;
	}

	public void setItems(java.util.List<OrderItem> items) {
		this.items = items;
	}

}