package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import com.example.entity.Review;
import com.example.entity.User;
import com.example.entity.Product;
import com.example.repository.ReviewRepository;
import com.example.repository.UserRepository;
import com.example.service.ProductService;

@Controller
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/addReview")
    public String addReview(@RequestParam Long productId, @RequestParam int rating, @RequestParam String comment, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        if (!productService.productExists(productId)) {
            return "redirect:/products";
        }

        Product product = productService.getProductReference(productId);
        User userRef = userRepository.getReferenceById(user.getId());
        Review review = new Review(userRef, product, rating, comment);
        reviewRepository.save(review);

        return "redirect:/products";
    }

    @GetMapping("/admin/reviews")
    public String adminReviews(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }
        model.addAttribute("list", reviewRepository.findAllWithUserAndProduct());
        return "admin/reviews";
    }

    @GetMapping("/admin/deleteReview/{id}")
    public String deleteReview(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("admin") != null) {
            try {
                reviewRepository.deleteReviewsByIds(java.util.Collections.singletonList(id));
                session.setAttribute("successMsg", "Review deleted successfully.");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Failed to delete review: " + e.getMessage());
            }
        }
        return "redirect:/admin/reviews";
    }

    @PostMapping("/admin/deleteBulkReviews")
    public String deleteBulkReviews(@RequestParam(value = "reviewIds", required = false) java.util.List<Long> reviewIds, HttpSession session) {
        if (session.getAttribute("admin") != null && reviewIds != null && !reviewIds.isEmpty()) {
            try {
                reviewRepository.deleteReviewsByIds(reviewIds);
                session.setAttribute("successMsg", "Successfully deleted " + reviewIds.size() + " reviews.");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Failed to delete: " + e.getMessage());
            }
        } else {
            session.setAttribute("errorMsg", "No reviews selected or invalid session.");
        }
        return "redirect:/admin/reviews";
    }
}
