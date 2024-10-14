# Utilisation de l'image Ubuntu comme base
FROM ubuntu:20.04

# Mainteneur de l'image (optionnel)
LABEL maintainer="votre-email@example.com"

# Désactiver les interactions pendant l'installation des paquets
ARG DEBIAN_FRONTEND=noninteractive

# Mise à jour des paquets et installation des outils de base
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    sudo \
    curl \
    git \
    vim \
    bash \
    net-tools \
    iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# Création d'un utilisateur non-root (optionnel)
RUN useradd -ms /bin/bash utilisateur && \
    echo "utilisateur:password" | chpasswd && \
    adduser utilisateur sudo

# Configuration du serveur SSH
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Autoriser le port 22 (SSH)
EXPOSE 22

# Commande pour démarrer le serveur SSH
CMD ["/usr/sbin/sshd", "-D"]