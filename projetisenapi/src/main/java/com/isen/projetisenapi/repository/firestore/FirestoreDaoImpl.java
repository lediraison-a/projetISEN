package com.isen.projetisenapi.repository.firestore;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

// https://firebase.google.com/docs/firestore/quickstart
// https://cloud.google.com/firestore/docs/create-database-server-client-library?hl=fr

@Repository
public class FirestoreDaoImpl implements FirestoreDao {
    private static final String COLLECTION = "allergens";
    private static final String ALLERGENS_FIELD_NAME = "allergens";

    private final Firestore db;

    public FirestoreDaoImpl(
            @Value("${dao.firestore.authFilepath}") String authFilepath,
            @Value("${dao.firestore.projectId}") String projectId
    ) throws IOException {
        var serviceAccount = new FileInputStream(authFilepath);
        var firestoreOptions =
                FirestoreOptions.getDefaultInstance().toBuilder()
                        .setProjectId(projectId)
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .build();
        this.db = firestoreOptions.getService();
    }

    @Override
    public List<String> getUserAllergens(String userId) throws ExecutionException, InterruptedException {
        var query = db.collection(COLLECTION).document(userId);
        var querySnapshot = query.get();
        var document = querySnapshot.get();
        return (List<String>) document.get(ALLERGENS_FIELD_NAME);
    }

    @Override
    public void setUserAllergens(String userId, List<String> allergens) throws ExecutionException, InterruptedException {
        var query = db.collection(COLLECTION).document(userId);
        Map<String, Object> data = new HashMap<>();
        data.put(ALLERGENS_FIELD_NAME, allergens);
        query.set(data).get();
    }
}
