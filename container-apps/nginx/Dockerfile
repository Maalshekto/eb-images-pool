# Utiliser l'image officielle de Nginx comme image de base
FROM nginx:alpine

# Copier des fichiers de configuration Nginx personnalisés si nécessaire
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Copier le contenu de votre application dans le dossier par défaut de Nginx
# (optionnel, selon votre utilisation)
# COPY ./html /usr/share/nginx/html

# Exposer le port 80 pour que Nginx soit accessible
EXPOSE 80

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]