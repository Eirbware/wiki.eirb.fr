# wiki.eirb.fr

## Installation

Steps needed :

1. Add db dump & configure `LocalSettings.php`
2. Build

### DB dump

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

### `wiki/LocalSettings.php`

1. Complete the following variables in `wiki/LocalSettings.php`, for example :

```php
$wgSitename = "wiki.eirb.fr";
$wgServer = "https://wiki.eirb.fr";
```

2. Generate a database password and configure `docker-compose.yml` and `wiki/LocalSettings.php` :

```php
## Database settings
$wgDBtype = "mysql";
$wgDBserver = "wiki-mariadb";
$wgDBname = "wiki";
$wgDBuser = "wiki";
$wgDBpassword = "example";
```

3. Finally, fill the `$wgPluggableAuth_Config` variable with `connect.eirb.fr` client configuration, for example :

```php
$wgPluggableAuth_Config[] = [
    'plugin' => 'OpenIDConnect',
    'data' => [
        'providerURL' => 'https://connect.eirb.fr/realms/eirb',
        'clientID' => 'wiki',
        'clientsecret' => '123467890abcdefghijklm',
        'preferred_username' => 'uid'
    ],
];
```

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

