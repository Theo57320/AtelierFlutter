# Application mobile ( Flutter ) 

Cette application mobile permet de créer un évènenent en fournissant le titre, description, date, heure, lieu. 
Lorsqu'un évéement est crée elle peut donc être partagé -> Invitation des membres inscrits.
Nous pouvons aussi lors de la création de l'événement, permettre la géolocalisation du lieu sur une carte géographique.


Pour utiliser cette application vous pouvez la lancer grâce à un émulateur  ou un smartphone android.

Cette application vous redirigeras vers une interface de connexion pour les utilisateurs inscrits.

Une fois connecté l'utilisateur voit une carte sur laquelle il y a des points qui sont tout les événements auquels il est invité.

Si il clique sur un événement il peut décider de participer ou non et peux acceder à une page indiquant les participants et les commentaires, il a la possibilité d'ajouter un commentaire.

Sur la page avec la map il y a 4 boutons :
  - Créer un event qui redirige vers la page pour créer un event avec le libelle de l'event, la description, l'adresse du lieu, la date et l'horaire.
  - Profil pour afficher les infos du profils nom prenom mail avec la possibilité de les modifiers
  - Deconnexion pour se deconnecter
  - Mes events qui affiche la liste des events créer par l'utilisateur avec la possibilité de cliquer dessus, ce qui affiche des infos sur l'event et la liste des utilisateurs avec un bouton pour inviter chaque utilisateur.


## Participants

Theo Antolini, Valentin Bardet, Hugo Georg, Thibault Amagat

## A savoir

Problème de rechargement des données :

Lors de la création d'un event il faut se reconnecter.

Lors de l'ajout d'un message il faut ajouter le message, retourner à la map et aller à nouveau sur la page des participants et commentaires.
