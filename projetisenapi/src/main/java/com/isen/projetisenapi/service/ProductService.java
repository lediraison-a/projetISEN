package com.isen.projetisenapi.service;

import com.isen.projetisenapi.models.ProductInfo;
import com.isen.projetisenapi.repository.openfood.OpenFoodDao;
import com.isen.projetisenapi.utils.exception.ApiError;
import com.isen.projetisenapi.utils.mapper.ProductMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClientResponseException;

@Service
public class ProductService {

    private static final Logger LOG = LoggerFactory.getLogger(ProductService.class);
    private final OpenFoodDao openFoodDao;

    public ProductService(OpenFoodDao openFoodDao) {
        this.openFoodDao = openFoodDao;
    }

    public ProductInfo getProductInfo(String barcode) {
        LOG.info("getProductInfo {}", barcode);
        ProductInfo productInfo;
        try {
            productInfo = ProductMapper.getProductInfo(openFoodDao.getProduct(barcode));
        } catch (WebClientResponseException e) {
            LOG.error(e.getMessage());
            throw new ApiError(String.format("Cannot get product data %s", barcode));
        } catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
        return productInfo;
    }

}
