package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.entity.Product;
import com.example.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private com.example.repository.CategoryRepository categoryRepository;

	@GetMapping("/products")
	public String products(Model model) {
		model.addAttribute("products", productService.getAllProducts());
		model.addAttribute("categories", categoryRepository.findAll());
		return "user/products";
	}

	@GetMapping("/viewProducts")
	public String viewProducts(Model model) {
		model.addAttribute("products", productService.getAllProducts());
		return "admin/view-product";
	}

	@GetMapping("/addProduct")
	public String addProduct(Model model) {
		model.addAttribute("product", new Product());
		model.addAttribute("categories", categoryRepository.findAll());
		return "admin/add-product";
	}

	@org.springframework.beans.factory.annotation.Value("${foodiehub.upload.dir}")
	private String UPLOAD_DIR;

	@PostMapping("/saveProduct")
	@org.springframework.web.bind.annotation.ResponseBody
	public org.springframework.http.ResponseEntity<String> saveProduct(
			@RequestParam String name,
			@RequestParam double price,
			@RequestParam String description,
			@RequestParam(required=false) String image,
			@RequestParam(required=false) Long categoryId,
			@RequestParam(defaultValue="true") boolean available,
			@RequestParam(value="imageFile", required=false) org.springframework.web.multipart.MultipartFile file) {
		try {
			Product product = new Product();
			product.setName(name);
			product.setPrice(price);
			product.setDescription(description);
			product.setAvailable(available);

			// Fetch Category from DB
			if (categoryId != null) {
				categoryRepository.findById(categoryId).ifPresent(product::setCategory);
			}

			// Handle image file upload — try, but don't fail product save if upload fails
			String savedImage = null;
			if (file != null && !file.isEmpty()) {
				try {
					// Use absolute path relative to working dir or project
					java.io.File uploadDir = new java.io.File(UPLOAD_DIR);
					if (!uploadDir.isAbsolute()) {
						// Resolve relative to current working directory
						uploadDir = uploadDir.getAbsoluteFile();
					}
					if (!uploadDir.exists()) uploadDir.mkdirs();
					String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
					java.io.File dest = new java.io.File(uploadDir, filename);
					file.transferTo(dest);
					savedImage = filename;
					System.out.println("Image saved to: " + dest.getAbsolutePath());
				} catch (Exception imgEx) {
					System.err.println("Image upload failed (product will still be saved): " + imgEx.getMessage());
				}
			}

			// Set image: uploaded file > URL/filename text > null
			if (savedImage != null) {
				product.setImage(savedImage);
			} else if (image != null && !image.trim().isEmpty()) {
				product.setImage(image.trim());
			}

			productService.saveProduct(product);
			return org.springframework.http.ResponseEntity.ok("success");
		} catch (Exception e) {
			e.printStackTrace();
			return org.springframework.http.ResponseEntity.status(500).body("error: " + e.getMessage());
		}
	}

	@GetMapping("/editProduct/{id}")
	public String editProduct(@PathVariable Long id, Model model) {
		Product product = productService.getProductById(id);
		model.addAttribute("product", product);
		model.addAttribute("categories", categoryRepository.findAll());
		return "admin/edit-product";
	}

	@PostMapping("/updateProduct")
	public String updateProduct(
			@RequestParam Long id,
			@RequestParam String name,
			@RequestParam double price,
			@RequestParam String description,
			@RequestParam(required=false) String image,
			@RequestParam(required=false) Long categoryId,
			@RequestParam(defaultValue="true") boolean available,
			@RequestParam(value="imageFile", required=false) org.springframework.web.multipart.MultipartFile file) {
		try {
			Product product = productService.getProductById(id);
			if (product == null) return "redirect:/viewProducts";

			product.setName(name);
			product.setPrice(price);
			product.setDescription(description);
			product.setAvailable(available);

			// Fetch Category from DB
			if (categoryId != null) {
				categoryRepository.findById(categoryId).ifPresent(product::setCategory);
			}

			// Handle image
			if (file != null && !file.isEmpty()) {
				java.io.File dir = new java.io.File(UPLOAD_DIR);
				if (!dir.exists()) dir.mkdirs();
				String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				file.transferTo(new java.io.File(dir, filename));
				product.setImage(filename);
			} else if (image != null && !image.trim().isEmpty()) {
				product.setImage(image.trim());
			}

			productService.updateProduct(product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/viewProducts";
	}

	@GetMapping("/deleteProduct/{id}")
	public String delete(@PathVariable Long id) {
		productService.deleteProduct(id);
		return "redirect:/viewProducts";
	}

}