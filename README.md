# wiki.eirb.fr

Ce dépôt contient les modifications faites à [mediawiki](https://www.mediawiki.org/wiki/MediaWiki) pour  [wiki.eirb.fr](https://wiki.eirb.fr).

## Utilisation (docker-compose)

Nous conseillons l'utilisation de [Docker Compose](https://docs.docker.com/compose/), le fichier `docker-compose.yml`
suivant peut servir de base pour déployer le site.

Note : cette image a pour but d'être utilisée dans le cadre d'Eirbware, elle
n'est probablement pas utilisable pour un evironnement différent.

```yaml
services:
  mediawiki:
    image: ghcr.io/eirbware/wiki.eirb.fr:main
    container_name: mediawiki
    restart: unless-stopped
    ports:
      - 8080:80
    depends_on:
      - wiki-mariadb
    environment:
      - USE_DEBUG=true  # must exactly equal to "true"
      - SITE_NAME=wiki.eirb.fr
      - SERVER=http://localhost:8080
      - MYSQL_DBSERVER=wiki-mariadb
      - MYSQL_DATABASE=wiki
      - MYSQL_USER=wiki
      - MYSQL_PASSWORD=ch4nge_it
      - KC_PROVIDER=https://connect.eirb.fr/realms/eirb
      - KC_CLIENT_ID=wiki
      - KC_CLIENT_SECRET=REPLACE_THIS_BY_THE_RIGHT_SECRET
      - WG_SECRET_KEY=SOMETHING_RANDOM
      - WG_UPGRADE_KEY=SOMETHING_RANDOM
    volumes:
      - ./wiki/images:/var/www/html/images

  # https://docs.linuxserver.io/images/docker-mariadb
  wiki-mariadb:
    image: lscr.io/linuxserver/mariadb:latest
    container_name: wiki-mariadb
    environment:
      - PUID=1000
      - PGID=1001
      - TZ=Etc/UTC
      - MYSQL_ROOT_PASSWORD=ROOT_ACCESS_PASSWORD
      - MYSQL_DATABASE=wiki
      - MYSQL_USER=wiki
      - MYSQL_PASSWORD=ch4nge_it
    volumes:
      - ./mariadb:/config
    restart: unless-stopped
```
