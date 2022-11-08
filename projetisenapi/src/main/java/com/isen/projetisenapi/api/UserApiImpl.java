package com.isen.projetisenapi.api;

import com.isen.projetisenapi.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class UserApiImpl extends AbstractApi implements UserApi {

    private final UserService userService;

    public UserApiImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    public ResponseEntity<List<String>> userAllergensGet() {
        return ResponseEntity.ok(userService.getUserAllergens(getPrincipal().getName()));
    }

    @Override
    public ResponseEntity<Void> userAllergensPut(List<String> requestBody) {
        userService.setUserAllergens(getPrincipal().getName(), requestBody);
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<List<String>> userProductBarcodeAllergensGet(String barcode) {
        return ResponseEntity.ok(userService.getProductUserAllergens(getPrincipal().getName(), barcode));
    }
}
