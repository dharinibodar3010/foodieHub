package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Product;
import com.example.repository.ProductRepository;
import com.example.repository.ReviewRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private ReviewRepository reviewRepository;

	// Add Product

	public Product saveProduct(Product product) {

		return productRepository.save(product);

	}

	// View All Product

	public List<Product> getAllProducts() {
		List<Product> products = productRepository.findAll();
		populateRatingStats(products);
		return products;
	}

	// Find Product

	public Product getProductById(Long id) {

		return productRepository.findById(id).orElse(null);

	}

	public boolean productExists(Long id) {
		return productRepository.existsById(id);
	}

	public Product getProductReference(Long id) {
		return productRepository.getReferenceById(id);
	}

	private void populateRatingStats(List<Product> products) {
		Map<Long, double[]> statsByProductId = new HashMap<>();
		for (Object[] row : reviewRepository.findRatingStatsByProduct()) {
			Long productId = (Long) row[0];
			double average = row[1] != null ? ((Number) row[1]).doubleValue() : 0.0;
			int count = row[2] != null ? ((Number) row[2]).intValue() : 0;
			statsByProductId.put(productId, new double[] { average, count });
		}

		for (Product product : products) {
			double[] stats = statsByProductId.get(product.getId());
			if (stats != null) {
				product.setCachedRatingStats(Math.round(stats[0] * 10.0) / 10.0, (int) stats[1]);
			} else {
				product.setCachedRatingStats(0.0, 0);
			}
		}
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