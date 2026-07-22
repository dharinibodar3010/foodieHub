package com.example.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.example.entity.Admin;
import com.example.repository.AdminRepository;

@Component
public class DataInitializer implements CommandLineRunner {

	@Value("${admin.default.username}")
	private String defaultAdminUsername;

	@Value("${admin.default.password}")
	private String defaultAdminPassword;

	private final AdminRepository adminRepo;

	public DataInitializer(AdminRepository adminRepo) {
		this.adminRepo = adminRepo;
	}

	@Override
	public void run(String... args) throws Exception {
		// Create Default Admin User from Environment Variables if not exists
		if (adminRepo.count() == 0) {
			adminRepo.save(new Admin(null, defaultAdminUsername, defaultAdminPassword));
		}
	}
}
