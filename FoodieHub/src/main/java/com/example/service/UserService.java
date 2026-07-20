package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.User;
import com.example.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	// Save User (Register)

	public User saveUser(User user) {

		return userRepository.save(user);

	}

	// Get All Users

	public List<User> getAllUsers() {

		return userRepository.findAll();

	}

	// Get User By Id

	public User getUserById(Long id) {

		return userRepository.findById(id).orElse(null);

	}

	// Delete User

	public void deleteUser(Long id) {

		userRepository.deleteById(id);

	}

	// Login

	public User login(String email, String password) {

		User user = userRepository.findByEmail(email);

		if (user != null && user.getPassword().equals(password)) {

			return user;

		}

		return null;

	}

}