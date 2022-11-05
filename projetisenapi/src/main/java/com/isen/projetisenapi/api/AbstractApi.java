package com.isen.projetisenapi.api;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.security.Principal;
import java.util.Objects;

@SecurityRequirement(name = "BearerAuthentication")
public class AbstractApi {

    protected Principal getPrincipal() {
        return ((ServletRequestAttributes)
                Objects.requireNonNull(RequestContextHolder.getRequestAttributes()))
                .getRequest()
                .getUserPrincipal();
    }
}
