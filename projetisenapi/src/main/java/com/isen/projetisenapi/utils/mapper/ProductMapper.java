package com.isen.projetisenapi.utils.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.isen.projetisenapi.models.ProductInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.stream.StreamSupport;

public class ProductMapper {
    private static final Logger LOG = LoggerFactory.getLogger(ProductMapper.class);
    public static ProductInfo getProductInfo(String productJson) throws Exception {
        LOG.info("getProductInfo");
        var rootNode = new ObjectMapper().readTree(productJson);

        var status = rootNode.get("status").asInt();
        if (status == 0) {
            throw new Exception("product not found");
        }
        var name = rootNode.get("product").get("product_name").asText();
        var barcode = rootNode.get("code").asText();
        var allergensTags = StreamSupport
                .stream(rootNode.get("product").get("allergens_tags").spliterator(), false)
                .map(jsonNode -> jsonNode.asText().substring(3)).toList();
        var allergensImported = Arrays.asList(rootNode.get("product")
                .get("allergens_imported").asText().split(", "));

        return new ProductInfo(barcode, name, allergensTags, allergensImported);
    }
}
