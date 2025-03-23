## Stack technologique

- Langage de programmation : Python 3.10
- Framework : FastAPI
- Validateur : Pydantic
- Base de données : PostgreSQL
- ORM : SQLAlchemy
- Architecture d'API : REST

## Installation du projet — Chat-Gptouille
### 1. Installer Ollama (pour le chatbot local)
Télécharger Ollama ici : https://ollama.com/

Une fois installé, ouvrir un terminal et exécuter les commandes suivantes :
```bash
ollama pull qwen2.5
ollama pull all-minilm
```
Tester l’installation avec :
```bash
ollama serve
```
Si le message suivant s’affiche :
Error: listen tcp 127.0.0.1:11434: bind: Only one usage of each socket address...
Cela signifie simplement qu’Ollama est déjà en cours d’exécution. Tout fonctionne correctement.

### 2. Installer Docker
Docker est requis pour lancer l’API et la base de données.
Il est recommandé d’utiliser Docker Desktop :
https://www.docker.com/products/docker-desktop/

### 3. Cloner le projet
git clone https://github.com/paullouppe/chat-gptouille
cd chat-gptouille

### 4. Configurer les variables d’environnement
Renommer les fichiers .env.example en .env :
 - Pour l’API : api/.env.example → api/.env
 - Pour la base de données : db/.env.example → db/.env

### 5. Lancer le projet
Dans un premier terminal :
```bash
docker compose up
```
Dans un second terminal, accéder au dossier Flutter, puis installer les dépendances et lancer l'application :
```bash
cd flutter_app
flutter pub get #si necessaire
flutter run
```

### 6. Utiliser le chatbot
Important : cette étape nécessite un ordinateur suffisamment puissant.
Une fois l’API lancée, exécuter la commande suivante pour charger le chatbot (génération des embeddings) :
```bash
curl -X 'GET' 'http://localhost:8080/chat/load' -H 'accept: application/json'
```
### 7. Accéder à l'application
L’application se lance automatiquement dans l'interface de votre choix.
Créez un compte, connectez-vous, et vous arriverez sur la page principale.

## Adminer (interface web d'administration de base de données)
<http://localhost:8181>

- Interface d'administration web
- Sélectionner Système : __postgresql__
- Serveur : __db__
- Utilisateur : cf. ./db/.env
- Mot de passe : cf. ./db/.env
- Base de données : cf. ./db/.env
