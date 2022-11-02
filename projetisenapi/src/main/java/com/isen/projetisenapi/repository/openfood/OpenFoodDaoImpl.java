package com.isen.projetisenapi.repository.openfood;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.reactive.function.client.WebClient;

@Repository
public class OpenFoodDaoImpl implements OpenFoodDao {

    private final WebClient webClient;

    @Value("${dao.openfood.url}")
    private String apiBaseUri;
    private final String GET_PRODUCT_URI = "/api/v2/product/{barcode}";

    public OpenFoodDaoImpl() {
        this.webClient = WebClient.create(apiBaseUri);
    }

    @Override
    public String getProduct(String barcode) {
        return webClient.get()
                .uri(GET_PRODUCT_URI, barcode)
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }
}
