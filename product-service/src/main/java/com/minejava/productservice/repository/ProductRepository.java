package com.minejava.productservice.repository;

import com.minejava.productservice.domain.Product;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProductRepository extends MongoRepository<Product, String> {

}
