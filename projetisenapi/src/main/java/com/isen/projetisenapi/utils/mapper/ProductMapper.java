package com.isen.projetisenapi.utils.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.isen.projetisenapi.models.ProductInfo;

import java.util.Arrays;
import java.util.stream.StreamSupport;

public class ProductMapper {
    public static ProductInfo getProductInfo(String productJson) throws JsonProcessingException {
        var rootNode = new ObjectMapper().readTree(productJson);


        var name = rootNode.get("product").get("product_name").asText();
        var barcode = rootNode.get("code").asText();
        var allergensTags = StreamSupport
                .stream(rootNode.get("product").get("allergens_tags").spliterator(), false)
                .map(JsonNode::asText).toList();
        var allergensImported = Arrays.asList(rootNode.get("product")
                .get("allergens_imported").asText().split(", "));

        return new ProductInfo(barcode, name, allergensTags, allergensImported);
    }
}