package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.entity.Review;
import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByProductId(Long productId);
    List<Review> findByUserId(Long userId);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.transaction.annotation.Transactional
    @org.springframework.data.jpa.repository.Query("DELETE FROM Review r WHERE r.id IN :ids")
    void deleteReviewsByIds(@org.springframework.data.repository.query.Param("ids") List<Long> ids);
}
