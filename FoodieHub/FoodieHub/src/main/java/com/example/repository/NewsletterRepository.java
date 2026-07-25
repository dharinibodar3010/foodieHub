package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.entity.Newsletter;

public interface NewsletterRepository extends JpaRepository<Newsletter, Long> {
    Newsletter findByEmail(String email);
}
