# 🚀 MongoDB Secured Blog Database (Docker Image)

Ce projet propose une implémentation **sécurisée et prête à l’emploi** de MongoDB, encapsulée dans une image Docker personnalisée.

Conçue pour un moteur de blog, cette solution automatise le déploiement d'une base de données tout en appliquant des règles strictes de **sécurité**, **validation des données** et **bonnes pratiques DevOps** dès le premier lancement.

---

## ✨ Points Forts

### ⚡ Initialisation Automatisée

* Création automatique de la base `blog_db`
* Création de la collection `posts`
* Insertion de données de test

### 🛡️ Intégrité des Données

* Implémentation d’un **JSON Schema Validator**
* Validation stricte des types :

  * `titre` → string
  * `auteur` → string
  * `vues` → integer

### 🔐 Sécurité Native

* Image basée sur **UBI (Universal Base Image)** → surface d’attaque réduite
* Exécution sous utilisateur **non-root (`mongodb`)**
* Secrets injectés via variables d’environnement (**aucune donnée sensible en dur**)

---

## 📂 Structure du Projet

```bash
.
├── Dockerfile          # Construction de l’image sécurisée
├── init-db.js          # Initialisation DB + schéma + données
├── check-status.sh     # Script de vérification (sécurité + accessibilité)
├── .env.example        # Modèle de variables d’environnement
└── README.md           # Documentation
```

---

## 🛠️ Guide de Déploiement

### 1. Configuration

Créer votre fichier `.env` :

```bash
cp .env.example .env
```

Puis renseignez :

```env
MONGO_INITDB_ROOT_USERNAME=admin
MONGO_INITDB_ROOT_PASSWORD=securepassword
```

---

### 2. Build de l’image

```bash
docker build -t alongkornfr/mongo-exo:1.0.0 .
```

---

### 3. Lancement du conteneur

```bash
docker run -d \
  --name blog-mongo-app \
  --env-file .env \
  -p 27017:27017 \
  alongkornfr/mongo-exo:1.0.0
```

---

## 🔍 Validation & Tests

### ✅ Vérification du statut

```bash
chmod +x check-status.sh
./check-status.sh
```

Ce script vérifie :

* que MongoDB tourne correctement
* que le conteneur n’est **pas en root**
* que la base est bien initialisée

---

### 🧪 Test du validateur NoSQL

Essayez d’insérer un document invalide :

```bash
docker exec -it blog-mongo-app mongosh \
-u [USER] -p [PASS] \
--authenticationDatabase admin \
--eval "db.getSiblingDB('blog_db').posts.insertOne({titre: 101, auteur: 'Admin', vues: NumberInt(5)})"
```

### 🔴 Résultat attendu

```
Document failed validation
```

➡️ Cela confirme que le schéma bloque les données incorrectes.

---

## 📦 Image Docker

Disponible sur Docker Hub :

```
alongkornfr/mongo-exo:1.0.0
```

Projet DevOps / Sécurité MongoDB
