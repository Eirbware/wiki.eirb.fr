# Some extensions need to be installed, to make the process easier, this
# makefile was made.
#
# Some extensions requires newer versions of media wiki, refer to
# https://hub.docker.com/_/mediawiki to know the current latest one
#
# In order to download the right one, we use branch_release variable to define
# the branch to clone (see next link)
# https://www.mediawiki.org/wiki/Download_from_Git#Download_a_stable_branch
PHONY += all
all: build

PHONY += dbshell
dbshell:
	docker compose up wiki-mariadb -d
	docker exec -it wiki-mariadb mariadb wiki

PHONY += dbdump
dbdump:
	docker compose up wiki-mariadb -d
	docker exec -it wiki-mariadb mariadb-dump wiki --result-file=/config/dump.sql
	echo "The dump is available in mariadb/dump.sql"

PHONY += build
build:
	docker buildx -t eirbware/mediawiki build .

PHONY += clean
clean:
	docker compose down

PHONY += mrproper
mrproper: clean
	rm -rf mariadb wiki/images

.PHONY: $(PHONY)
