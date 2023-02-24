package com.isen.projetisenapi.service;

import com.isen.projetisenapi.repository.firestore.FirestoreDao;
import com.isen.projetisenapi.utils.exception.ApiError;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    private static final Logger LOG = LoggerFactory.getLogger(UserService.class);
    private final FirestoreDao firestoreDao;

    private final ProductService productService;

    public UserService(FirestoreDao firestoreDao, ProductService productService) {
        this.firestoreDao = firestoreDao;
        this.productService = productService;
    }

    public List<String> getUserAllergens(String userId) {
        LOG.info("getUserAllergens {}", userId);
        List<String> userAllergens = null;
        try {
            userAllergens = firestoreDao.getUserAllergens(userId);
            if (userAllergens == null) {
                return new ArrayList<>();
            }
        } catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
        return userAllergens;
    }

    public void setUserAllergens(String userId, List<String> allergens) {
        LOG.info("setUserAllergens {}", userId);
        try {
            firestoreDao.setUserAllergens(userId, allergens);
        } catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
    }

    public List<String> getProductUserAllergens(String userId, String barcode) {
        LOG.info("getProductUserAllergens {} {}", userId, barcode);
        List<String> productUserAllergens;
        try {
            var userAllergens = firestoreDao.getUserAllergens(userId)
                    .stream()
                    .map(String::toLowerCase)
                    .toList();
            productUserAllergens = productService.getProductInfo(barcode)
                    .getAllergensTags()
                    .stream()
                    .map(String::toLowerCase)
                    .filter(userAllergens::contains)
                    .toList();
        }
        catch (ApiError e) {
            LOG.error(e.getMessage());
            throw e;
        }
        catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
        return productUserAllergens;
    }
}
