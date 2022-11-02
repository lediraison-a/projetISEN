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

    private final Firestore db;

    @Value("${dao.firestore.authFilepath}")
    private static String authFilepath;
    private static final String PROJECT_ID = "projetisen-dd64c";
    private static final String COLLECTION = "allergens";

    public FirestoreDaoImpl() throws IOException {
        var serviceAccount = new FileInputStream(authFilepath);
        var firestoreOptions =
                FirestoreOptions.getDefaultInstance().toBuilder()
                        .setProjectId(PROJECT_ID)
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .build();
        this.db = firestoreOptions.getService();
    }

    @Override
    public List<String> getUserAllergens(String userId) throws ExecutionException, InterruptedException {
        var query = db.collection(COLLECTION).document(userId);
        var querySnapshot = query.get();
        var document = querySnapshot.get();
        return (List<String>) document.get(COLLECTION);
    }

    @Override
    public void setUserAllergens(String userId, List<String> allergens) throws ExecutionException, InterruptedException {
        var query = db.collection(COLLECTION).document(userId);
        Map<String, Object> data = new HashMap<>();
        data.put(COLLECTION, allergens);
        query.set(data).get();
    }
}
