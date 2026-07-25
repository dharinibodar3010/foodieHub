package com.example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

	List<Cart> findByUserId(Long userId);
	
	List<Cart> findByUser(com.example.entity.User user);

	Cart findByUserIdAndProductId(Long userId, Long productId);
	
	Cart findByUserAndProduct(com.example.entity.User user, com.example.entity.Product product);

}