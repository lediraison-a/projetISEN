package com.isen.projetisenapi.api;

import com.isen.projetisenapi.api.models.Product;
import com.isen.projetisenapi.service.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class ProductApiImpl extends AbstractApi implements ProductApi {

    private final ProductService productService;

    public ProductApiImpl(ProductService productService) {
        this.productService = productService;
    }

    @Override
    public ResponseEntity<List<String>> productBarcodeAllergensGet(String barcode) {
        var product = productService.getProductInfo(barcode);
        return ResponseEntity.ok(product.getAllergensTags());
    }

    @Override
    public ResponseEntity<Product> productBarcodeGet(String barcode) {
        var product = productService.getProductInfo(barcode);
        var productOutput = new Product();
        productOutput.setName(product.getName());
        productOutput.setBarcode(product.getBarcode());
        productOutput.setAllergens(product.getAllergensTags());
        return ResponseEntity.ok(productOutput);
    }
}
