package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

import com.example.entity.Admin;
import com.example.repository.AdminRepository;

@Controller
public class AdminController {

	@Autowired
	private AdminRepository adminRepository;

	@org.springframework.beans.factory.annotation.Value("${admin.default.username}")
	private String defaultUsername;

	@org.springframework.beans.factory.annotation.Value("${admin.default.password}")
	private String defaultPassword;

	@GetMapping("/admin")
	public String adminLogin(HttpSession session) {
		if (session.getAttribute("admin") != null) {
			return "redirect:/dashboard";
		}
		return "admin/admin-login";
	}

	@GetMapping("/adminLogout")
	public String adminLogout(HttpSession session) {
		session.removeAttribute("admin");
		return "redirect:/admin";
	}

	@PostMapping("/adminLogin")
	public String login(@RequestParam String username, @RequestParam String password, Model model,
			HttpSession session) {

		// First, check if the credentials match the environment variables directly
		if (defaultUsername.equals(username) && defaultPassword.equals(password)) {
			Admin admin = adminRepository.findByUsername(username);
			if (admin == null) {
				admin = new Admin();
				admin.setUsername(username);
				admin.setPassword(password);
				adminRepository.save(admin);
			}
			session.setAttribute("admin", admin);
			return "redirect:/dashboard";
		}

		Admin admin = adminRepository.findByUsername(username);

		if (admin != null && admin.getPassword().equals(password)) {
			session.setAttribute("admin", admin);
			return "redirect:/dashboard";
		} else {
			model.addAttribute("error", "Invalid Admin Username or Password");
			return "admin/admin-login";
		}
	}

	@org.springframework.web.bind.annotation.ResponseBody
	@PostMapping("/admin/reset-access")
	public org.springframework.http.ResponseEntity<String> resetAccess(
			@org.springframework.beans.factory.annotation.Value("${admin.default.username}") String defaultUsername,
			@org.springframework.beans.factory.annotation.Value("${admin.default.password}") String defaultPassword) {
		
		adminRepository.deleteAll(); // Wipe all existing admins
		adminRepository.save(new Admin(null, defaultUsername, defaultPassword)); // Create fresh from env vars
		
		return new org.springframework.http.ResponseEntity<>("Admin credentials restored successfully! You can now log in.", org.springframework.http.HttpStatus.OK);
	}

	@Autowired
	private com.example.service.UserService userService;

	@Autowired
	private com.example.service.ProductService productService;

	@Autowired
	private com.example.repository.NewsletterRepository newsletterRepository;

	@Autowired
	private com.example.service.EmailService emailService;

	@GetMapping("/admin/newsletters")
	public String newsletters(HttpSession session, Model model) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		model.addAttribute("list", newsletterRepository.findAll());
		return "admin/newsletters";
	}

	@PostMapping("/admin/sendBulkNewsletter")
	public String sendBulkNewsletter(@RequestParam String subject, @RequestParam String message, HttpSession session) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		try {
			java.util.List<com.example.entity.Newsletter> subscribers = newsletterRepository.findAll();
			for (com.example.entity.Newsletter sub : subscribers) {
				emailService.sendEmail(sub.getEmail(), subject, message);
			}
			session.setAttribute("successMsg", "Emails sent successfully to " + subscribers.size() + " subscribers.");
		} catch (Exception e) {
			session.setAttribute("errorMsg", "Failed to send emails: " + e.getMessage());
		}
		return "redirect:/admin/newsletters";
	}

	@PostMapping("/admin/sendSingleNewsletter")
	public String sendSingleNewsletter(@RequestParam String email, @RequestParam String subject, @RequestParam String message, HttpSession session) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		try {
			emailService.sendEmail(email, subject, message);
			session.setAttribute("successMsg", "Email sent successfully to " + email);
		} catch (Exception e) {
			session.setAttribute("errorMsg", "Failed to send email to " + email + ": " + e.getMessage());
		}
		return "redirect:/admin/newsletters";
	}

	// ડેશબોર્ડ પેજ
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		
		java.util.List<com.example.entity.Order> allOrders = orderService.getAllOrders();
		
		double totalRevenue = 0;
		int totalOrders = allOrders.size();
		int totalUsers = userService.getAllUsers().size();
		int totalProducts = productService.getAllProducts().size();

		java.util.List<com.example.entity.Order> recentOrders = new java.util.ArrayList<>();
		for (int i = allOrders.size() - 1; i >= Math.max(0, allOrders.size() - 5); i--) {
			recentOrders.add(allOrders.get(i));
		}

		// Calculate weekly revenue array (Mon to Sun)
		double[] weeklyRevenue = new double[7];
		java.time.LocalDate now = java.time.LocalDate.now();
		java.time.LocalDate startOfWeek = now.minusDays(now.getDayOfWeek().getValue() - 1);

		for (com.example.entity.Order order : allOrders) {
			if ("Delivered".equals(order.getStatus()) || "Placed".equals(order.getStatus())
					|| "Order Placed".equals(order.getStatus()) || "On The Way".equals(order.getStatus())) {
				totalRevenue += order.getTotalAmount();
				
				java.time.LocalDate orderDate = order.getOrderDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
				if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(startOfWeek.plusDays(6))) {
					int dayIndex = orderDate.getDayOfWeek().getValue() - 1;
					weeklyRevenue[dayIndex] += order.getTotalAmount();
				}
			}
		}

		model.addAttribute("totalRevenue", totalRevenue);
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("totalProducts", totalProducts);
		model.addAttribute("recentOrders", recentOrders);
		
		StringBuilder weeklyRevStr = new StringBuilder("[");
		for (int i=0; i<7; i++) {
			weeklyRevStr.append(weeklyRevenue[i]).append(i<6 ? "," : "");
		}
		weeklyRevStr.append("]");
		model.addAttribute("weeklyRevenueData", weeklyRevStr.toString());

		return "admin/dashboard";
	}

	@GetMapping("/adminChangePassword")
	public String changePasswordPage(HttpSession session) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		return "admin/change-password";
	}

	@PostMapping("/adminChangePassword")
	public String changePassword(@RequestParam String oldPassword, 
			@RequestParam(required = false) String newUsername, 
			@RequestParam(required = false) String newPassword,
			HttpSession session, Model model) {
		Admin loggedInAdmin = (Admin) session.getAttribute("admin");
		if (loggedInAdmin == null) {
			return "redirect:/admin";
		}

		Admin admin = adminRepository.findById(loggedInAdmin.getId()).orElse(null);
		if (admin != null && admin.getPassword().equals(oldPassword)) {
			boolean updated = false;
			if (newUsername != null && !newUsername.trim().isEmpty()) {
				admin.setUsername(newUsername.trim());
				updated = true;
			}
			if (newPassword != null && !newPassword.trim().isEmpty()) {
				admin.setPassword(newPassword.trim());
				updated = true;
			}
			
			if (updated) {
				adminRepository.save(admin);
				session.setAttribute("admin", admin);
				model.addAttribute("msg", "Profile updated successfully!");
			} else {
				model.addAttribute("msg", "No changes were made.");
			}
		} else {
			model.addAttribute("error", "Incorrect old password!");
		}
		return "admin/change-password";
	}

	@Autowired
	private com.example.service.OrderService orderService;

	@GetMapping("/adminOrders")
	public String adminOrders(HttpSession session, Model model) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		model.addAttribute("orders", orderService.getAllOrders());
		return "admin/orders";
	}

	@PostMapping("/updateOrderStatus")
	public String updateOrderStatus(@RequestParam Long id, @RequestParam String status, HttpSession session) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}
		com.example.entity.Order order = orderService.getOrderById(id);
		if (order != null) {
			order.setStatus(status);
			orderService.saveOrder(order);
		}
		return "redirect:/adminOrders";
	}

	@GetMapping("/salesReport")
	public String salesReport(@RequestParam(defaultValue = "daily") String filter,
			@RequestParam(required = false) String startDate, @RequestParam(required = false) String endDate,
			HttpSession session, Model model) {
		if (session.getAttribute("admin") == null) {
			return "redirect:/admin";
		}

		java.util.List<com.example.entity.Order> allOrders = orderService.getAllOrders();
		java.util.List<com.example.entity.Order> filteredOrders = new java.util.ArrayList<>();

		java.time.LocalDate now = java.time.LocalDate.now();
		double totalRevenue = 0;

		java.time.LocalDate start = null;
		java.time.LocalDate end = null;
		if ("custom".equalsIgnoreCase(filter) && startDate != null && endDate != null && !startDate.isEmpty()
				&& !endDate.isEmpty()) {
			start = java.time.LocalDate.parse(startDate);
			end = java.time.LocalDate.parse(endDate);
		}

		for (com.example.entity.Order order : allOrders) {
			java.time.LocalDate orderDate = order.getOrderDate().toInstant().atZone(java.time.ZoneId.systemDefault())
					.toLocalDate();
			boolean matches = false;

			if ("daily".equalsIgnoreCase(filter)) {
				matches = orderDate.isEqual(now);
			} else if ("weekly".equalsIgnoreCase(filter)) {
				matches = orderDate.isAfter(now.minusDays(7)) || orderDate.isEqual(now.minusDays(7));
			} else if ("monthly".equalsIgnoreCase(filter)) {
				matches = orderDate.getMonth() == now.getMonth() && orderDate.getYear() == now.getYear();
			} else if ("yearly".equalsIgnoreCase(filter)) {
				matches = orderDate.getYear() == now.getYear();
			} else if ("custom".equalsIgnoreCase(filter) && start != null && end != null) {
				matches = (orderDate.isEqual(start) || orderDate.isAfter(start))
						&& (orderDate.isEqual(end) || orderDate.isBefore(end));
			} else {
				matches = true;
			}

			if (matches) {
				filteredOrders.add(order);
				if ("Delivered".equals(order.getStatus()) || "Placed".equals(order.getStatus())
						|| "Order Placed".equals(order.getStatus()) || "On The Way".equals(order.getStatus())) {
					totalRevenue += order.getTotalAmount();
				}
			}
		}

		model.addAttribute("orders", filteredOrders);
		model.addAttribute("totalRevenue", totalRevenue);
		model.addAttribute("totalOrders", filteredOrders.size());
		model.addAttribute("currentFilter", filter);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "admin/sales-report";
	}
}