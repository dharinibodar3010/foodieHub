package com.example.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.EmailService;

@RestController
@RequestMapping("/api/forgot-password")
public class ForgotPasswordController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @PostMapping("/send-otp")
    public ResponseEntity<String> sendOtp(@RequestParam String email) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            return new ResponseEntity<>("User not found with this email", HttpStatus.NOT_FOUND);
        }

        // Generate a 6-digit OTP
        String token = String.format("%06d", new java.util.Random().nextInt(999999));
        user.setResetToken(token);
        userRepository.save(user);

        // Send email asynchronously
        String subject = "Password Reset OTP - FoodieHub";
        String body = "Hello " + user.getName() + ",\n\n" +
                "You requested a password reset. Here is your 6-digit OTP:\n\n" +
                token + "\n\n" +
                "If you did not request this, please ignore this email.";
        
        emailService.sendEmail(user.getEmail(), subject, body);

        return new ResponseEntity<>("Password reset token sent to your email successfully.", HttpStatus.OK);
    }

    @PostMapping("/reset")
    public ResponseEntity<String> resetPassword(@RequestParam String token, @RequestParam String newPassword) {
        User user = userRepository.findByResetToken(token);
        if (user == null) {
            return new ResponseEntity<>("Invalid or expired reset token", HttpStatus.BAD_REQUEST);
        }

        // Update password and clear token
        user.setPassword(newPassword);
        user.setResetToken(null);
        userRepository.save(user);

        return new ResponseEntity<>("Password has been reset successfully.", HttpStatus.OK);
    }
}
