package com.example.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.entity.Admin;
import com.example.repository.AdminRepository;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private AdminRepository adminRepository;

    @Override
    public void run(String... args) throws Exception {
        
        String adminPass = System.getenv("admin");
        if (adminPass == null || adminPass.isEmpty()) {
            adminPass = "tempAdmin123"; // Dummy password for local
        }

        // First Admin
        if (adminRepository.findByUsername("admin") == null) {
            Admin admin1 = new Admin();
            admin1.setUsername("admin");
            admin1.setPassword(adminPass);
            adminRepository.save(admin1);
        }

        // Second Admin
        if (adminRepository.findByUsername("admin2") == null) {
            Admin admin2 = new Admin();
            admin2.setUsername("admin2");
            admin2.setPassword(adminPass);
            adminRepository.save(admin2);
        }
    }
}
