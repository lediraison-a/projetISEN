package com.isen.projetisenapi.repository.firebaseAdmin;

import com.google.firebase.auth.FirebaseAuthException;
import com.isen.projetisenapi.models.UserInfo;

import java.util.List;

public interface FirebaseAdminRepository {
    List<UserInfo> listUsers() throws FirebaseAuthException;
    void disableUser(String uid) throws FirebaseAuthException;
    void activateUsers(String uid) throws FirebaseAuthException;
}
