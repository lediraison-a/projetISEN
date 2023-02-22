package com.isen.projetisenapi.service;

import com.google.firebase.auth.FirebaseAuthException;
import com.isen.projetisenapi.models.UserInfo;
import com.isen.projetisenapi.repository.firebaseAdmin.FirebaseAdminRepositoryImpl;
import com.isen.projetisenapi.utils.exception.ApiError;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {
    private final Logger LOG = LoggerFactory.getLogger(AllergenService.class);
    private final FirebaseAdminRepositoryImpl firebaseAdminRepository;

    public AdminService(FirebaseAdminRepositoryImpl firebaseAdminRepository) {
        this.firebaseAdminRepository = firebaseAdminRepository;
    }

    public List<UserInfo> listUsers() {
        LOG.info("Listing users");
        List<UserInfo> listUsers;
        try {
            listUsers = firebaseAdminRepository.listUsers();
        } catch (FirebaseAuthException e) {
            throw new ApiError(e.getMessage());
        }
        return listUsers;
    }

    public void disableUser(String uid) {
        LOG.info("Disabling user {}", uid);
        try {
            firebaseAdminRepository.disableUser(uid);
        } catch (FirebaseAuthException e) {
            throw new ApiError(e.getMessage());
        }
    }

    public void activateUser(String uid) {
        LOG.info("Activate user {}", uid);
        try {
            firebaseAdminRepository.activateUsers(uid);
        } catch (FirebaseAuthException e) {
            throw new ApiError(e.getMessage());
        }
    }
}
