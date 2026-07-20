package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import com.example.repository.CategoryRepository;
import com.example.entity.Category;

@SpringBootApplication
public class FoodieHubApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodieHubApplication.class, args);
	}

	@Bean
	public CommandLineRunner dataLoader(CategoryRepository categoryRepo) {
		return args -> {
			if (categoryRepo.count() == 0) {
				categoryRepo.save(new Category(null, "Pizza", "Delicious handmade pizzas"));
				categoryRepo.save(new Category(null, "Burger", "Juicy and classic burgers"));
				categoryRepo.save(new Category(null, "Biryani", "Authentic and spicy biryani"));
				categoryRepo.save(new Category(null, "Desserts", "Sweet treats and cakes"));
				categoryRepo.save(new Category(null, "Drinks", "Refreshing beverages"));
			}
		};
	}

}
