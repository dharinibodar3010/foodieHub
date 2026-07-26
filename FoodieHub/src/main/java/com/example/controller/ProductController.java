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

	@GetMapping("/product")
	public String productDetails(@RequestParam("id") Long id, Model model) {
		Product product = productService.getProductById(id);
		if (product == null) {
			return "redirect:/products";
		}
		model.addAttribute("product", product);
		
		java.util.List<Product> allProducts = productService.getAllProducts();
		java.util.List<Product> relatedProducts = new java.util.ArrayList<>();
		for(Product p : allProducts) {
			if(!p.getId().equals(product.getId())) {
				relatedProducts.add(p);
			}
		}
		java.util.Collections.shuffle(relatedProducts);
		model.addAttribute("relatedProducts", relatedProducts);
		
		return "user/product-details";
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

	@org.springframework.beans.factory.annotation.Value("${imgbb.api.key}")
	private String imgbbApiKey;

	// Upload image to Imgbb and return public URL
	private String uploadToImgbb(org.springframework.web.multipart.MultipartFile file) {
		try {
			byte[] bytes = file.getBytes();
			String base64Image = java.util.Base64.getEncoder().encodeToString(bytes);

			org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
			org.springframework.util.MultiValueMap<String, String> formData = new org.springframework.util.LinkedMultiValueMap<>();
			formData.add("key", imgbbApiKey);
			formData.add("image", base64Image);

			org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
			headers.setContentType(org.springframework.http.MediaType.APPLICATION_FORM_URLENCODED);

			org.springframework.http.HttpEntity<org.springframework.util.MultiValueMap<String, String>> request =
					new org.springframework.http.HttpEntity<>(formData, headers);

			org.springframework.http.ResponseEntity<java.util.Map> response =
					restTemplate.postForEntity("https://api.imgbb.com/1/upload", request, java.util.Map.class);

			if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
				java.util.Map<String, Object> body = response.getBody();
				if (body.containsKey("data")) {
					java.util.Map<String, Object> data = (java.util.Map<String, Object>) body.get("data");
					String url = (String) data.get("url");
					if (url != null && !url.isEmpty()) {
						System.out.println("Imgbb upload success: " + url);
						return url;
					}
				}
			}
		} catch (Exception e) {
			System.err.println("Imgbb upload failed: " + e.getMessage());
		}
		return null;
	}

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

			// Handle image: try Imgbb upload first, fallback to URL text
			String savedImage = null;
			if (file != null && !file.isEmpty()) {
				// Try Imgbb API upload
				savedImage = uploadToImgbb(file);
				// Fallback: local file save
				if (savedImage == null) {
					try {
						java.io.File uploadDir = new java.io.File(UPLOAD_DIR);
						if (!uploadDir.exists()) uploadDir.mkdirs();
						String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
						java.io.File dest = new java.io.File(uploadDir, filename);
						file.transferTo(dest);
						savedImage = filename;
					} catch (Exception imgEx) {
						System.err.println("Local save also failed: " + imgEx.getMessage());
					}
				}
			}

			// Set image: uploaded > URL text > null
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

			// Handle image: try Imgbb upload first, fallback to URL text
			if (file != null && !file.isEmpty()) {
				String imgUrl = uploadToImgbb(file);
				if (imgUrl != null) {
					product.setImage(imgUrl);
				} else {
					// Fallback: local file save
					try {
						java.io.File dir = new java.io.File(UPLOAD_DIR);
						if (!dir.exists()) dir.mkdirs();
						String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
						file.transferTo(new java.io.File(dir, filename));
						product.setImage(filename);
					} catch (Exception ex) {
						System.err.println("Local save failed: " + ex.getMessage());
					}
				}
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