package com.minejava.orderservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

// define method and annotate so that code is generated
// No need to initialize any objects because spring does it automatically
@FeignClient(name = "inventory-service")
public interface InventoryClient {
    @GetMapping("/api/inventory/{skuCode}")
    Boolean checkStock(@PathVariable String skuCode);
}
