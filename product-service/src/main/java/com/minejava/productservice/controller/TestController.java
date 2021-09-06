package com.minejava.productservice.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
@RefreshScope // when controller is called, bean is refreshed
public class TestController {

    @Value("${test1.name}")
    private String name;

    @GetMapping
    public String test() {
        return name;
    }
}
