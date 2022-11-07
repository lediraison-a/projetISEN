package com.isen.projetisenapi.repository.openfood;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class OpenFoodDaoImplTest {

    @Autowired
    private OpenFoodDao openFoodDao;

    @Test
    void getProduct() throws JsonProcessingException {
        var barcode = "3017620422003";
//        var productName = "Nutella";
//        var allergens = List.of("en:milk", "en:nuts", "en:soybeans");
//        var allergensImported = List.of("Lait", "Fruits à coque", "Soja");
//        var product = new Product(openFoodDao.getProduct(barcode));
//        assertThat(product).isNotNull()
//                .extracting(
//                        Product::getBarcode,
//                        Product::getProductName,
//                        Product::getAllergensTags,
//                        Product::getAllergensImported)
//                .contains(
//                        barcode,
//                        productName,
//                        allergens,
//                        allergensImported);

        var product = openFoodDao.getProduct(barcode);
        assertThat(product).isNotNull().isInstanceOf(String.class);
    }
}