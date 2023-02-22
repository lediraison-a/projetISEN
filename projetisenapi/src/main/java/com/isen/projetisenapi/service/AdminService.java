package com.isen.projetisenapi.service;

import com.google.firebase.auth.FirebaseAuthException;
import com.isen.projetisenapi.models.UserInfo;
import com.isen.projetisenapi.repository.firebaseAdmin.FirebaseAdminRepositoryImpl;
import com.isen.projetisenapi.repository.firestore.FirestoreDao;
import com.isen.projetisenapi.utils.exception.ApiError;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class AdminService {
    private final Logger LOG = LoggerFactory.getLogger(AdminService.class);
    private final FirebaseAdminRepositoryImpl firebaseAdminRepository;
    private final FirestoreDao firestoreDao;

    public AdminService(FirebaseAdminRepositoryImpl firebaseAdminRepository, FirestoreDao firestoreDao) {
        this.firebaseAdminRepository = firebaseAdminRepository;
        this.firestoreDao = firestoreDao;
    }

    public List<UserInfo> listUsers() {
        LOG.info("Listing users");
        List<UserInfo> listUsers;
        try {
            listUsers = firebaseAdminRepository.listUsers();
        } catch (FirebaseAuthException e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
        return listUsers;
    }

    public void updateUsers(List<String> admins, List<String> deactivated, List<String> reactivated, String userId) {
        setAdmins(admins, userId);
        deactivated.forEach(this::disableUser);
        reactivated.forEach(this::activateUser);
    }

    public void disableUser(String uid) {
        LOG.info("Disabling user {}", uid);
        try {
            firebaseAdminRepository.disableUser(uid);
        } catch (FirebaseAuthException e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
    }

    public void activateUser(String uid) {
        LOG.info("Activate user {}", uid);
        try {
            firebaseAdminRepository.activateUsers(uid);
        } catch (FirebaseAuthException e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
    }

    public boolean isAdmin(String userId) {
        return getAdmins().contains(userId);
    }

    @Cacheable(value = "admins")
    public List<String> getAdmins() {
        try {
            return firestoreDao.getAdmins();
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
    }

    @CacheEvict(value = "admins", allEntries = true)
    public void setAdmins(List<String> admins, String userId) {
        LOG.info("user {} set the admins list", userId);
        try {
            if(!admins.contains(userId)) {
                admins.add(userId);
            }
            firestoreDao.setAdmins(admins);
        } catch (Exception e) {
            LOG.error(e.getMessage());
            throw new ApiError(e.getMessage());
        }
    }
}
