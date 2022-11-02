package com.isen.projetisenapi.utils.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

public class Product {

    private final JsonNode rootNode;

    public Product(String productJson) throws JsonProcessingException {
        rootNode = new ObjectMapper().readTree(productJson);
    }

    public String getProductName() {
        return rootNode.get("product").get("product_name").asText();
    }

    public String getBarcode() {
        return rootNode.get("code").asText();
    }

    public List<String> getAllergens() {
        return StreamSupport
                .stream(rootNode.get("product").get("allergens_tags").spliterator(), false)
                .map(JsonNode::asText)
                .collect(Collectors.toList());
    }

    public List<String> getAllergensImported() {
        return Arrays.asList(rootNode.get("product").get("allergens_imported").asText().split(", "));
    }

}
