# Projet ISEN API

## Start Local 

install java jdk 17

place the authorization file (projetisen-dd64c-firebase-adminsdk-d0aq1-b3f1a453eb.json) in /srv/projetisenapi

```shell
./gradlew openApiGenerate

./gradlew bootRun
```

## Documentation 

[swagger ui](http://localhost:8080/swagger-ui/index.html)


## Deploy

```shell
./gradlew openApiGenerate

./gradlew build

docker build . -t projetisenapi

docker run -v /srv/projetisenapi:/srv/projetisenapi -p 8081:8080 projetisenapi
```

url : http://localhost:8081/projetisenapi/swagger-ui/index.html