# wiki.eirb.fr

## Installation

Steps needed :

1. Install plugins and start the containers
2. Load wiki dump
3. Update db and plugins

### Plugins installation

Run the following command :

```sh
make build
docker compose up -d --force-recreate
```

### Load wiki dump

You should have a wiki media dump if you're working on this, otherwise contact
an Eirbware member, more information might be found at https://docs.eirb.fr

1. place the dump `wiki_dump.sql` in the directory `mariadb`
2. execute :

```sh
docker exec -it wiki-mariadb bash
```

3. exec in container's shell :

```sh
mariadb wiki < /config/wiki.sql
exit
```

### Update db and plugin

Media wiki provides a migration tool, to use it do :

```sh
docker exec -it mediawiki ./maintenance/run update
```

## Migration (2025)

Obligé d'exécuter

```sh
mariadb wiki < wiki_dump.sql
```

Puis dans le conteneur du wiki :

```sh
./maintenance/run update
```

