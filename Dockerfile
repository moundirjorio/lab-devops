# 1. Image Python legere
FROM python:3.11-slim

# 2. Repertoire de travail dans le conteneur
WORKDIR /app

# 3. Empecher Python de generer des fichiers .pyc et forcer l'affichage des logs
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 4. Installer les dependances systeme necessaires
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 5. Copier le fichier des dependances et les installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copier tout le reste du code du projet
COPY . .

# 7. Exposer le port (Railway utilisera la variable $PORT)
EXPOSE 8000

# 8. Commande de lancement compatible Railway et local
# Si $PORT est defini (Railway) -> on l'utilise, sinon on prend 8000 (local)
CMD python manage.py runserver 0.0.0.0:${PORT:-8000}
