# MongoDB

Ce projet présente une implémentation durcie de MongoDB, encapsulée dans une image Docker personnalisée. Conçue pour un moteur de blog, cette solution automatise le déploiement d'une base de données prête à l'emploi tout en appliquant des règles de sécurité et d'intégrité strictes dès le premier lancement.

## ✨ Points Forts

- **Initialisation Automatisée** : Provisionnement immédiat de la base `blog_db` et de sa collection `posts`.
- **Intégrité des Données** : Implémentation d'un **JSON Schema Validator** (NoSQL) pour garantir la conformité des articles (types de champs forcés).
- **Sécurité Native** : 
    - Image de base **UBI** (Universal Base Image) pour réduire la surface d'attaque.
    - Exécution sous un **utilisateur non-privilégié** (`mongodb`).
    - Injection de secrets via variables d'environnement (zéro identifiant en dur).

---

## 📂 Structure du Dépôt

- `Dockerfile` : Définition de l'image sécurisée et configuration utilisateur.
- `init-db.js` : Script JS gérant la création du schéma, du validateur et des données de test.
- `check-status.sh` : Script Bash de diagnostic (utilisateur & accessibilité).
- `.env.example` : Modèle de configuration pour les variables d'environnement.

---

## 🛠️ Guide de Déploiement

### 1. Configuration
Préparez votre environnement en créant un fichier `.env` à partir du modèle :
```bash
cp .env.example .env

2. Build et Exécution
Générez l'image et lancez le conteneur :

# Build de l'image (tag 1.0.0)
docker build -t alongkornfr/mongo-exo:1.0.0 .

# Lancement du service
docker run -d \
  --name blog-mongo-app \
  --env-file .env \
  -p 27017:27017 \
  alongkornfr/mongo-exo:1.0.0

  🔍 Validation & Tests
Vérification du statut
Lancez le script de viabilité pour confirmer que le service tourne sans privilèges root et que les données sont chargées :