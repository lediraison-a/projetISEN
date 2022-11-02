package com.isen.projetisenapi.dao.openfood;

import org.springframework.stereotype.Repository;
import org.springframework.web.reactive.function.client.WebClient;

@Repository
public class OpenFoodDaoImpl implements OpenFoodDao {

    private final WebClient webClient;

    private final String BASE_URI = "https://world.openfoodfacts.org";

    private final String GET_PRODUCT_URI = "/api/v2/product/{barcode}";

    public OpenFoodDaoImpl() {
        this.webClient = WebClient.create(BASE_URI);
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
