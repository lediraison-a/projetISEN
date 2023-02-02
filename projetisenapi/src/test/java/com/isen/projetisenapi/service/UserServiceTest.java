package com.isen.projetisenapi.service;

import org.junit.jupiter.api.Disabled;
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
        var userId = "fn4L91yEbzTbYDwgvqv0mjrLt9E2";
        assertThat(userService.getUserAllergens(userId)).contains("Lait");
    }

    @Test
    void setUserAllergens() {
        var userId = "fn4L91yEbzTbYDwgvqv0mjrLt9E2";
//        Assertions.assertThatCode(() -> userService.setUserAllergens(userId, List.of("Lait"))
//                .doesNotThrowAnyException();
    }

    @Test
    @Disabled
    void getProductUserAllergens() {
        var userId = "fn4L91yEbzTbYDwgvqv0mjrLt9E2";
        var barcode = "3017620422003";
        var productUserAllergens = userService.getProductUserAllergens(userId, barcode);
        assertThat(productUserAllergens).contains("lait");
    }
}