#!/bin/bash

echo "--- Vérification de l'utilisateur ---"
# Teste si l'utilisateur est root ou non
USER_INTERNAL=$(docker exec mongo-exo whoami)
if [ "$USER_INTERNAL" = "root" ]; then
    echo "ERREUR : Le service tourne en tant que ROOT (danger !)"
    exit 1
else
    echo "SUCCÈS : Le service tourne en tant que : $USER_INTERNAL"
fi

echo "--- Vérification de la base de données ---"
# Teste si on peut lire les 5 articles dans blog_db
COUNT=$(docker exec mongo-exo mongosh --quiet --eval "db.getSiblingDB('blog_db').posts.countDocuments()")

if [ "$COUNT" -eq 5 ]; then
    echo "SUCCÈS : 5 articles trouvés dans la collection 'posts'."
else
    echo "ERREUR : Base de données vide ou inaccessible (Trouvé : $COUNT)"
    exit 1
fi

echo "--- TEST GLOBAL RÉUSSI ---"