package com.isen.projetisenapi.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.validation.constraints.Null;

import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class AllergenServiceTest {

    @Autowired
    private AllergenService allergenService;

    @Test
    void getAllergens() {
        var allergens = allergenService.getAllergens();
        assertThat(allergens).isInstanceOf(List.class).asList().isNotEmpty();
    }
}