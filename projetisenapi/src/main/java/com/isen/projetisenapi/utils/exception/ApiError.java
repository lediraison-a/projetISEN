package com.isen.projetisenapi.utils.exception;

public class ApiError extends RuntimeException {

    public ApiError(String message) {
        super(message);
    }
}
