package com.isen.projetisenapi.api;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/app")
@SecurityRequirement(name = "BearerAuthentication")
public class TestApi {

    @GetMapping(path = "/test")
    public String test(Principal principal) {
        return principal.getName();
    }

}
