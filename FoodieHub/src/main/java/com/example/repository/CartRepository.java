package com.example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

	List<Cart> findByUserId(Long userId);

	Cart findByUserIdAndProductId(Long userId, Long productId);

}