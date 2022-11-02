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

    public void getUserAllergens(String userId) {
        try {
            var allergens = firestoreDao.getUserAllergens(userId);
        } catch (Exception e) {

        }
    }

    public void setUserAllergens(String userId, List<String> allergens) {
        try {
            firestoreDao.setUserAllergens(userId, allergens);
        } catch (Exception e) {

        }
    }

    public void isUserAllergique(String userId, String barcode) {
        try {
            var allergens = firestoreDao.getUserAllergens(userId);
            var product = new Product(openFoodDao.getProduct(barcode));
            var isAllergique = false;
            var allergenOk = "";
            for (String allergen : allergens) {
                if (product.getAllergens().contains(allergen)) {
                    allergenOk = allergen;
                    isAllergique = true;
                    break;
                }
            }
        } catch (Exception e) {

        }
    }
}
