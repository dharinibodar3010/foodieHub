package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Cart;
import com.example.repository.CartRepository;

@Service
public class CartService {

	@Autowired
	private CartRepository cartRepository;

	// Add To Cart

	public Cart addCart(Cart cart) {
		Cart existingCart = cartRepository.findByUserIdAndProductId(cart.getUser().getId(), cart.getProduct().getId());
		if (existingCart != null) {
			existingCart.setQuantity(existingCart.getQuantity() + cart.getQuantity());
			return cartRepository.save(existingCart);
		}
		return cartRepository.save(cart);
	}

	// View Cart

	public List<Cart> getUserCart(Long userId) {

		return cartRepository.findByUserId(userId);

	}

	// Update Cart

	public Cart updateCart(Cart cart) {

		return cartRepository.save(cart);

	}

	// Remove Cart Item

	public void deleteCart(Long id) {

		cartRepository.deleteById(id);

	}

}