# AppScale

Projet scale Armingaud Robin et Garnier Maxime

## Getting started

Le dossier /app contient l'application flutter.
Le dossier /scale server contient le code du serveur flask déployé à l'adresse https://serverscale.herokuapp.com/
L'application est constituée de 3 écrans :
- Accueil et login
- Profil
- Liste des utilisateurs

Les utilisateurs enregistrés sont :
- username : "truc" & password "a"
- username : "Brad" & password "a"
- username : "George" & password "a"

## Lancement de l'application

Le serveur étant déjà en ligne, il suffit d'exécuter 
'flutter run'  dans le répertoire 'app' en choisissant un appareil sur lequel faire tourner l'application.

## Fonctionnalités

L'application démarre sur l'écran de login. Pour se connecter, il suffit de rentrer un identifiant et l mot de passe correspondant déjà enregistrés sur le serveur. En cas de champ vide un message s'affiche invitant à le remplir et aucune requête n'est envoyée. 
Avant d'effectuer la requête de login, le client vérifie que l'empreinte du certificat du serveur est bien la même que celle pré-enregistrée et affiche un bandeau de notification en fonction des cas, en empêchant l'envoi de requête si la vérification du certificat renvoie une erreur.<br>
La connexion permet d'accéder à son ecran personnel de profil. Il contient la photo, le nom et la biographie de l'utilisateur. Il dispose de 2 boutons pour changer d'écran :<br>
-Un bouton de déconnexion <br>
-Un bouton pour accéder à la liste des utilisateurs<br>

L'écran de liste des utilisateurs affiche seulement la liste des noms et prénoms des utilisateurs de la base de données, accessible en clair via une requête. On ne peut pas accéder au profil des autres car on considère que le profil est personnel. Depuis l'écran d'annuaire, il est possible de retourner en arrière et donc recharger son profil sans effectuer de nouvelle requête, ou se déconnecter.

## Sécurité

- Les requêtes sont en HTTPS
- La seule requête permettant d'accéder aux données personnelles du profil est celle de login et elle vérifie que le certificat du serveur soit bien correct (SSL pinning)
- Les mots de passe sont stockés en hash
- Le serveur utilise Flask pour gérer les requêtes
- L'aspect du cryptage end to end a été envisagé et entamé mais n'a pas abouti.

## Stratégie de gestion de git

L'objectif initial était de mettre en place une branche par developpeur ainsi qu'une branche main. Il s'est avéré que j'ai été le seul contributeur du projet donc il n'y a pas eu à gérer de conflit.<br>
Concernant l'intégration continue, il est difficile de tester nos jobs car il n'y a jamais de machine disposant de flutter disponible sur gitlab.

## Pistes d'amélioration, gestion du temps, conclusion

Il reste encore à implémenter le cryptage end-to-end et la gestion du git pourrait être grandement améliorée. Un module d'authentification a été également implémenté à partir de flask login mais malheureusement les application flutter ne stockent pas correctement les sessions utilisateur. Il serait possible d'ajouter cette fonctionnalité avec des tokens et une autre librairie. <br>
Globalement, comme vous avez pu le comprendre, la gestion du temps pour réaliser ce projet a été complexe. J'ai été seul à réaliser l'intégralité du projet, du déploiement et de l'implémentation du serveur à la gestion du git.
Ceci est suvenu en même temps qu'une panne sur mon installation de Windows et de Flutter, ce qui m'a obligé à changer de système d'exploitation, ainsi que des horaires de stage extrêmement prenantes. 



