package com.isen.projetisenapi.repository.openfood;

import com.isen.projetisenapi.repository.firestore.FirestoreDaoImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.reactive.function.client.WebClient;

@Repository
public class OpenFoodDaoImpl implements OpenFoodDao {

    private static final Logger LOG = LoggerFactory.getLogger(FirestoreDaoImpl.class);
    private final WebClient webClient;

    public OpenFoodDaoImpl(@Value("${dao.openfood.url}") String apiBaseUri) {
        this.webClient = WebClient.create(apiBaseUri);
    }

    @Override
    public String getProduct(String barcode) throws RuntimeException {
        LOG.info("getProduct {}", barcode);
        String GET_PRODUCT_URI = "/api/v2/product/{barcode}";
        return webClient.get()
                .uri(GET_PRODUCT_URI, barcode)
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }
}
