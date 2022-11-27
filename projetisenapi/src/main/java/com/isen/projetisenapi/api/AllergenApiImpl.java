package com.isen.projetisenapi.api;

import com.isen.projetisenapi.service.AllergenService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class AllergenApiImpl extends AbstractApi implements AllergenApi {

    private final AllergenService allergenService;

    public AllergenApiImpl(AllergenService allergenService) {
        this.allergenService = allergenService;
    }

    @Override
    public ResponseEntity<List<String>> allergenGet() {
        return ResponseEntity.ok(allergenService.getAllergens());
    }
}
