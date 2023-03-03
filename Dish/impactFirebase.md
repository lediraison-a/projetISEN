# Impact utilisation de firebase

Dish utilise firebase pour deux choses :
- la gestion des utilisateurs
- le stockage des données utilisateurs

L'utilsiation de firebase à donc un impact sur deux choses.
Concernant le sockage des données utilisateurs, cela concerne seulement l'api. L'api est construite de
façon modulaire, donc peu de changements pour passer outre firebase.

Pour la gestion des utilisateurs, l'impact est plus important :
Un changement d'autorité d'authentification serait donc à faire sur l'application, l'ihm et l'api.
