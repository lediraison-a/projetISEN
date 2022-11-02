package com.isen.projetisenapi.repository.firestore;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.firestore.QueryDocumentSnapshot;
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

    private static final String AUTH_FILEPATH = "/home/alban/Téléchargements/projetisen-dd64c-firebase-adminsdk-d0aq1-b3f1a453eb.json";
    private static final String PROJECT_ID = "projetisen-dd64c";
    private static final String COLLECTION = "allergens";

    public FirestoreDaoImpl() throws IOException {
        var serviceAccount = new FileInputStream(AUTH_FILEPATH);
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
