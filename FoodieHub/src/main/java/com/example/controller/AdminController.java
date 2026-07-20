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

    // આ એડમિન પેજ ઓપન કરવા માટે છે
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

    // આ લોગીન બટન પર ક્લિક કર્યા પછી ચેક કરવા માટે છે (તમારી એરર આના વગર આવતી હતી)
    @PostMapping("/adminLogin")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpSession session) {
        
        Admin admin = adminRepository.findByUsername(username);
        
        if (admin != null && admin.getPassword().equals(password)) {
            session.setAttribute("admin", admin);
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Invalid Admin Username or Password");
            return "admin/admin-login";
        }
    }

    // ડેશબોર્ડ પેજ
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // જો લોગીન કર્યા વગર ડેશબોર્ડ ખોલે તો પાછું લોગીન પર મોકલી દેશે
        if(session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }
        return "admin/dashboard";
    }

    @Autowired
    private com.example.service.OrderService orderService;

    @GetMapping("/adminOrders")
    public String adminOrders(HttpSession session, Model model) {
        if(session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/orders";
    }

    @PostMapping("/updateOrderStatus")
    public String updateOrderStatus(@RequestParam Long id, @RequestParam String status, HttpSession session) {
        if(session.getAttribute("admin") == null) {
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
                              @RequestParam(required = false) String startDate,
                              @RequestParam(required = false) String endDate,
                              HttpSession session, Model model) {
        if(session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }

        java.util.List<com.example.entity.Order> allOrders = orderService.getAllOrders();
        java.util.List<com.example.entity.Order> filteredOrders = new java.util.ArrayList<>();
        
        java.time.LocalDate now = java.time.LocalDate.now();
        double totalRevenue = 0;

        java.time.LocalDate start = null;
        java.time.LocalDate end = null;
        if ("custom".equalsIgnoreCase(filter) && startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
            start = java.time.LocalDate.parse(startDate);
            end = java.time.LocalDate.parse(endDate);
        }

        for (com.example.entity.Order order : allOrders) {
            java.time.LocalDate orderDate = order.getOrderDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
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
                matches = (orderDate.isEqual(start) || orderDate.isAfter(start)) && (orderDate.isEqual(end) || orderDate.isBefore(end));
            } else {
                matches = true;
            }

            if (matches) {
                filteredOrders.add(order);
                if ("Delivered".equals(order.getStatus()) || "Placed".equals(order.getStatus()) || "Order Placed".equals(order.getStatus()) || "On The Way".equals(order.getStatus())) {
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