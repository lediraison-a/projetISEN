package com.isen.projetisenapi.repository.firebaseAdmin;

import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.isen.projetisenapi.models.UserInfo;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class FirebaseAdminRepositoryImpl implements FirebaseAdminRepository {
    public FirebaseAdminRepositoryImpl() {
        FirebaseApp.initializeApp();
    }

    public List<UserInfo> listUsers() throws FirebaseAuthException {
        var page = FirebaseAuth.getInstance().listUsers(null);
        List<UserInfo> users = new ArrayList<>();
        page.iterateAll().forEach(e ->
                users.add(
                    new UserInfo(
                        e.getDisplayName(),
                        e.getUid(),
                        e.getEmail(),
                        e.isDisabled())
                )
        );
        return users;
    }

    public void disableUser(String uid) throws FirebaseAuthException {
        var request = new UserRecord.UpdateRequest(uid).setDisabled(true);
        FirebaseAuth.getInstance().updateUser(request);
    }

    public void activateUsers(String uid) throws FirebaseAuthException {
        var request = new UserRecord.UpdateRequest(uid).setDisabled(false);
        FirebaseAuth.getInstance().updateUser(request);
    }
}
