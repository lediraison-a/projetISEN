# Dish documentation téchnique

## Gestion des sources

Dans le répertoire de l'application il y'a un dossier pour chaque partie de Dish
- gl-flutter : application android
- projetisenapi : backend api
- web-projetISEN : IHM web

Dish est géré avec le dépot présent sur le gitlab de l'isen
https://web.isen-ouest.fr/gitlab/gl/projets-2223/equipe-2

## Serveur

Dish est hébergé sur la vm suivante :
http://vps-6d160f31.vps.ovh.net

Un utilisateur dish à été crée.
Dans le dossier home de cet utilisateur, il y'a une copie locale du dépot cité précédement dans un dossier "dish"


## Déployement

L'api et l'ihm sont dockerisé. Pour lancer les deux application simultanément il duffit de lancer la commande
```
docker compose up -d --build
```

Docker va compiler les applications et lancer les conteneurs.

Affin de lancer les applications il est nécessaire d'avoir certains fichiers de configuration sur le serveur :
- /srv/dish/allergens.json : fichier contenant la liste des allergenes
- /srv/dish/projetisen-dd64c-firebase-adminsdk-d0aq1-b3f1a453eb.json : fichier pour l'authentification à firebase.

Une fois les conteneurs lancés, vous pouvez acceder à l'ihm sur le port 80 du serveur, et l'api sur le port 8082.

L'url de l'interface swagger de l'api est la suivante :
http://<host>:8082/dishapi/swagger-ui/index.html

### Mise à jour

Il faut pull avec git la derniere version de la branche main du dépot, puis lancer la commande de déployement.
