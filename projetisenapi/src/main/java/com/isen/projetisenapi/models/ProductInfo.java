package com.isen.projetisenapi.models;

import java.util.List;

public class ProductInfo {
    private final String barcode;
    private final String name;
    private final List<String> allergensTags;

    public String getBarcode() {
        return barcode;
    }

    public String getName() {
        return name;
    }

    public List<String> getAllergensTags() {
        return allergensTags;
    }

    public ProductInfo(String barcode, String name, List<String> allergensTags) {
        this.barcode = barcode;
        this.name = name;
        this.allergensTags = allergensTags;
    }
}
