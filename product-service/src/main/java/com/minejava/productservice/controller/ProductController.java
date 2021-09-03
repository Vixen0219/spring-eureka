package com.minejava.productservice.controller;

import java.util.List;

import com.minejava.productservice.domain.Product;
import com.minejava.productservice.repository.ProductRepository;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController // exposes the rest API
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductRepository productRepository;

    // Returns list of products
    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Product> findAll() {
        // Making it
        return productRepository.findAll();
    }

    // returns status of product when created
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public void createProduct(@RequestBody Product product) {
        productRepository.save(product);
    }
}
