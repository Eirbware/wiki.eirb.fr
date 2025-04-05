# wiki.eirb.fr

## Installation

Steps needed :

1. Add db dump & configure `LocalSettings.php`
2. Build

### DB dump & `LocalSettings.php`

You should have a mediawiki dump if you're working on this, otherwise contact
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

Then add all secrets configurations in `wiki/LocalSettings.php`

### Build

Just do :

```sh
make install
```

And the server will start with all extensions installed and configured

## Migration (2025)

Obligé d'exécuter

```sh
mariadb wiki < wiki_dump.sql
```

Puis dans le conteneur du wiki :

```sh
./maintenance/run update
```

