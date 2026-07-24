package com.example.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.CascadeType;
import jakarta.persistence.FetchType;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "products")
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String name;

	private String description;

	private double price;

	private String image;

	private boolean available;

	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonIgnore
	private List<Review> reviews;

	@Transient
	private Double cachedAverageRating;

	@Transient
	private Integer cachedReviewCount;

	public Product() {

	}

	public Product(Long id, String name, String description, double price, String image, boolean available,
			Category category) {

		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.image = image;
		this.available = available;
		this.category = category;

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public void setCachedRatingStats(double averageRating, int reviewCount) {
		this.cachedAverageRating = averageRating;
		this.cachedReviewCount = reviewCount;
	}

	public double getAverageRating() {
		if (cachedAverageRating != null) {
			return cachedAverageRating;
		}
		if (reviews == null || reviews.isEmpty()) {
			return 0.0;
		}
		double sum = 0;
		for (Review r : reviews) {
			sum += r.getRating();
		}
		return Math.round((sum / reviews.size()) * 10.0) / 10.0;
	}

	public int getReviewCount() {
		if (cachedReviewCount != null) {
			return cachedReviewCount;
		}
		return reviews == null ? 0 : reviews.size();
	}
}