package com.isen.projetisenapi.repository.firestore;

import java.util.List;
import java.util.concurrent.ExecutionException;

public interface FirestoreDao {
    List<String> getUserAllergens(String userId) throws ExecutionException, InterruptedException;

    void setUserAllergens(String userId, List<String> allergens) throws ExecutionException, InterruptedException;

    List<String> getAdmins() throws ExecutionException, InterruptedException;
    void setAdmins(List<String> admins) throws ExecutionException, InterruptedException;
}
