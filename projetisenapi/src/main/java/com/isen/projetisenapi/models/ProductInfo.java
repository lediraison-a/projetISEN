package com.isen.projetisenapi.models;

import java.util.List;

public class ProductInfo {
    private final String barcode;
    private final String name;
    private final List<String> allergensTags;
    private final List<String> allergensImported;

    public String getBarcode() {
        return barcode;
    }

    public String getName() {
        return name;
    }

    public List<String> getAllergensTags() {
        return allergensTags;
    }

    public List<String> getAllergensImported() {
        return allergensImported;
    }

    public ProductInfo(String barcode, String name, List<String> allergensTags, List<String> allergensImported) {
        this.barcode = barcode;
        this.name = name;
        this.allergensTags = allergensTags;
        this.allergensImported = allergensImported;
    }
}
