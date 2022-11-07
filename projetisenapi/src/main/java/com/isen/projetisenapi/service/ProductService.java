package com.isen.projetisenapi.service;

import com.isen.projetisenapi.models.ProductInfo;
import com.isen.projetisenapi.repository.openfood.OpenFoodDao;
import com.isen.projetisenapi.utils.mapper.ProductMapper;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

    private final OpenFoodDao openFoodDao;

    public ProductService(OpenFoodDao openFoodDao) {
        this.openFoodDao = openFoodDao;
    }

    public ProductInfo getProductInfo(String barcode) {
        ProductInfo productInfo = null;
        try {
            productInfo = ProductMapper.getProductInfo(openFoodDao.getProduct(barcode));
        } catch (Exception e) {

        }
        return productInfo;
    }

}
