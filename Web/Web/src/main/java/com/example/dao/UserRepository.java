package com.example.dao;

import com.example.entity.Smart;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<Smart, Long> {

    @Query(value = "select * from smart where name like %?1%", nativeQuery = true)
    Page<Smart> findByNameLike(String name, Pageable pageRequest);
}
