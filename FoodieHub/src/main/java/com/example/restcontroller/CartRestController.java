package com.example.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.entity.Cart;
import com.example.repository.CartRepository;

@RestController
@RequestMapping("/api/carts")
public class CartRestController {

    @Autowired
    private CartRepository cartRepository;

    @GetMapping
    public List<Cart> getAllCarts() {
        return cartRepository.findAll();
    }

    @GetMapping("/{id}")
    public Cart getCartById(@PathVariable Long id) {
        return cartRepository.findById(id).orElse(null);
    }
}
