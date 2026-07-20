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

	public static String UPLOAD_DIR = System.getProperty("user.dir") + "/src/main/webapp/images";

	@PostMapping("/saveProduct")
	public String saveProduct(@ModelAttribute Product product, @RequestParam(value="imageFile", required=false) org.springframework.web.multipart.MultipartFile file) {
		try {
			if (file != null && !file.isEmpty()) {
				java.io.File dir = new java.io.File(UPLOAD_DIR);
				if (!dir.exists()) dir.mkdirs();
				String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				file.transferTo(new java.io.File(dir, filename));
				product.setImage(filename);
			}
			productService.saveProduct(product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/viewProducts";
	}

	@GetMapping("/editProduct/{id}")
	public String editProduct(@PathVariable Long id, Model model) {
		Product product = productService.getProductById(id);
		model.addAttribute("product", product);
		model.addAttribute("categories", categoryRepository.findAll());
		return "admin/edit-product";
	}

	@PostMapping("/updateProduct")
	public String updateProduct(@ModelAttribute Product product, @RequestParam(value="imageFile", required=false) org.springframework.web.multipart.MultipartFile file) {
		try {
			if (file != null && !file.isEmpty()) {
				java.io.File dir = new java.io.File(UPLOAD_DIR);
				if (!dir.exists()) dir.mkdirs();
				String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				file.transferTo(new java.io.File(dir, filename));
				product.setImage(filename);
			} else {
				if (product.getImage() == null || product.getImage().trim().isEmpty()) {
					Product old = productService.getProductById(product.getId());
					if (old != null) product.setImage(old.getImage());
				}
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