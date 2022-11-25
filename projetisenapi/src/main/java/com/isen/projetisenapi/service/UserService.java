package com.isen.projetisenapi.service;

import com.isen.projetisenapi.repository.firestore.FirestoreDao;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final FirestoreDao firestoreDao;

    private final ProductService productService;

    public UserService(FirestoreDao firestoreDao, ProductService productService) {
        this.firestoreDao = firestoreDao;
        this.productService = productService;
    }

    public List<String> getUserAllergens(String userId) {
        List<String> userAllergens = null;
        try {
            userAllergens = firestoreDao.getUserAllergens(userId);
        } catch (Exception e) {

        }
        return userAllergens;
    }

    public void setUserAllergens(String userId, List<String> allergens) {
        try {
            firestoreDao.setUserAllergens(userId, allergens);
        } catch (Exception e) {

        }
    }

    public List<String> getProductUserAllergens(String userId, String barcode) {
        List<String> productUserAllergens = null;
        try {
            var userAllergens = firestoreDao.getUserAllergens(userId)
                    .stream()
                    .map(String::toLowerCase)
                    .toList();
            productUserAllergens = productService.getProductInfo(barcode)
                    .getAllergensImported()
                    .stream()
                    .map(String::toLowerCase)
                    .filter(userAllergens::contains)
                    .toList();
        } catch (Exception e) {

        }
        return productUserAllergens;
    }
}
