package com.isen.projetisenapi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.StreamSupport;

@Service
public class AllergenService {

    private final Logger LOG = LoggerFactory.getLogger(AllergenService.class);
    private final List<String> allergens;

    public AllergenService(@Value("${allergens.filepath}") String allergensFilepath) throws IOException {
        var allergensFile = new File(allergensFilepath);
        var rootNode = new ObjectMapper().readTree(allergensFile);
        allergens = StreamSupport
                .stream(rootNode.spliterator(), false)
                .map(jsonNode -> jsonNode.get("name").get("fr").asText())
                .filter(s -> !s.equals("Aucun"))
                .toList();
    }

    public List<String> getAllergens() {
        LOG.info("getAllergens");
        return allergens;
    }

}
