package com.isen.projetisenapi.repository.firestore;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.concurrent.ExecutionException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.assertj.core.api.InstanceOfAssertFactories.LIST;

@SpringBootTest
class FirestoreDaoImplTest {

    @Autowired
    private FirestoreDao firestoreDao;

    @Test
    void getUserAllergens() throws ExecutionException, InterruptedException {
        var userId = "fn4L91yEbzTbYDwgvqv0mjrLt9E2";
        var allergens = firestoreDao.getUserAllergens(userId);
        assertThat(allergens).isNotNull().contains("Lait");

    }

    @Test
    void setUserAllergens() {
        var userId = "fn4L91yEbzTbYDwgvqv0mjrLt9E2";
        var allergens = List.of("Lait");
        Assertions.assertThatCode(() -> firestoreDao.setUserAllergens(userId, allergens))
                .doesNotThrowAnyException();
    }
}