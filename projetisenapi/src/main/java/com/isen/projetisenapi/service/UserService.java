package com.isen.projetisenapi.service;

import com.isen.projetisenapi.repository.firestore.FirestoreDao;
import com.isen.projetisenapi.repository.openfood.OpenFoodDao;
import com.isen.projetisenapi.utils.mapper.Product;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final FirestoreDao firestoreDao;

    private final OpenFoodDao openFoodDao;

    public UserService(FirestoreDao firestoreDao, OpenFoodDao openFoodDao) {
        this.firestoreDao = firestoreDao;
        this.openFoodDao = openFoodDao;
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
            var userAllergens = firestoreDao.getUserAllergens(userId);
            var product = new Product(openFoodDao.getProduct(barcode));
            productUserAllergens = product
                    .getAllergens()
                    .stream().filter(userAllergens::contains).toList();
        } catch (Exception e) {

        }
        return productUserAllergens;
    }
}
