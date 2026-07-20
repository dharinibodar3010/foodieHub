package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Product;
import com.example.repository.ProductRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;

	// Add Product

	public Product saveProduct(Product product) {

		return productRepository.save(product);

	}

	// View All Product

	public List<Product> getAllProducts() {

		return productRepository.findAll();

	}

	// Find Product

	public Product getProductById(Long id) {

		return productRepository.findById(id).orElse(null);

	}

	// Update Product

	public Product updateProduct(Product product) {

		return productRepository.save(product);

	}

	// Delete Product

	public void deleteProduct(Long id) {

		productRepository.deleteById(id);

	}

	// Search Product

	public List<Product> searchProduct(String name) {

		return productRepository.findByNameContainingIgnoreCase(name);

	}

}