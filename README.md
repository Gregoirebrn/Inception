# Projet Inception - 42

Ce projet a pour objectif de mettre en place un environnement de développement web complet en utilisant Docker et Docker Compose. L'objectif final est de faire fonctionner un site WordPress avec une persistance des données et un serveur web performant, tout en utilisant Nginx comme reverse proxy, MariaDB pour la gestion de la base de données, et WordPress pour le système de gestion de contenu.

## Prérequis

Avant de commencer, assurez-vous d'avoir les outils suivants installés sur votre machine :

- [Docker](https://www.docker.com/get-started) version 20.x ou supérieure
- [Docker Compose](https://docs.docker.com/compose/install/) version 1.29 ou supérieure

## Description du projet

Le projet consiste à configurer trois services principaux via Docker Compose :

- **Nginx** : Le serveur web servant de reverse proxy pour WordPress.
- **MariaDB** : La base de données utilisée par WordPress.
- **WordPress** : Le CMS qui sera utilisé pour créer et gérer le contenu du site.

Ces services sont définis dans un fichier `docker-compose.yml` et sont configurés pour communiquer entre eux dans un réseau isolé.

## Structure du projet

Le projet se compose des éléments suivants :

```
inception/
├── srcs/
│   ├── requirements/
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   ├── conf/
│   │   │   │   └── www.conf
│   │   │   └── tools/
│   │   │       └── wordpress.sh
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   ├── my.cnf
│   │   │   └── tools/
│   │   │       └── mariadb.sh
│   │   └── nginx/
│   │       ├── Dockerfile
│   │       └── conf/
│   │           └── nginx.conf
│   ├── .env
│   └── docker-compose.yml
│
├── Makefile
└── README.md

data/
├── wordpress/
└── mariadb/
```

## Installation

1. **Clonez le repository** :

   Si vous n'avez pas encore cloné le projet, commencez par le faire avec la commande suivante :

   ```bash
   git clone https://url-de-votre-repository.git
   cd inception
   ```

2. **Configurer le fichier `docker-compose.yml`** :

   Vérifiez que le fichier `docker-compose.yml` est bien configuré. Les services doivent être correctement définis pour que le projet fonctionne.

3. **Lancer les services avec Docker Compose** :

   Une fois que tout est installé, vous pouvez démarrer les services en utilisant la commande suivante :

   ```bash
   make
   ```

   Cette commande télécharge les images nécessaires et lance les conteneurs en arrière-plan.

4. **Accéder au site WordPress** :

   Une fois les services lancés, vous pouvez accéder à votre site WordPress à l'adresse suivante dans votre navigateur :

   ```
   http://grebrune.42.fr
   ```


## Structure du fichier `docker-compose.yml`

Voici un exemple de base pour votre fichier `docker-compose.yml` :

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - wordpress
    networks:
      - backend

  mariadb:
    image: mariadb:latest
    container_name: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: user
      MYSQL_PASSWORD: userpassword
    volumes:
      - mariadb_data:/var/lib/mysql
    networks:
      - backend

  wordpress:
    image: wordpress:latest
    container_name: wordpress
    environment:
      WORDPRESS_DB_HOST: mariadb:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: user
      WORDPRESS_DB_PASSWORD: userpassword
    ports:
      - "8080:80"
    depends_on:
      - mariadb
    networks:
      - backend

networks:
  backend:
    driver: bridge

volumes:
  mariadb_data:
    driver: local
```

## Configuration Nginx

Le fichier `nginx/conf/nginx.conf` contient la configuration pour que Nginx redirige les requêtes HTTP vers le service WordPress. Vous pouvez personnaliser cette configuration selon vos besoins. Par exemple, voici une configuration simple :

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://wordpress:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Persistance des données

Les données de MariaDB sont persistées à l'aide d'un volume Docker `mariadb_data` qui est monté sur `/var/lib/mysql` dans le conteneur MariaDB. Cela garantit que même si le conteneur MariaDB est supprimé et redémarré, les données restent intactes.

## Arrêter les services

Pour arrêter tous les services, exécutez :

```bash
make down
```

Cela arrêtera et supprimera tous les conteneurs sans supprimer les volumes.

## Dépannage

- Si vous rencontrez des problèmes pour accéder à votre site, vérifiez les logs des conteneurs avec la commande :

  ```bash
  make logs
  ```

- Si les services ne démarrent pas correctement, essayez de reconstruire les images et de redémarrer les conteneurs :

  ```bash
  make build
  ```

## Contribuer

Si vous souhaitez contribuer à ce projet, vous pouvez forker le repository, apporter vos modifications, puis soumettre une pull request.
