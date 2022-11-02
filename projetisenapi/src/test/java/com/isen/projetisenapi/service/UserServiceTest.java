package com.isen.projetisenapi.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    void getUserAllergens() {
    }

    @Test
    void setUserAllergens() {
    }

    @Test
    void getProductUserAllergens() {
        var userId = "";
        var barcode = "";
        var productUserAllergens = userService.getProductUserAllergens(userId, barcode);
        assertThat(productUserAllergens).contains("Lait");
    }
}