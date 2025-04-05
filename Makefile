# Some extensions need to be installed, to make the process easier, this
# makefile was made.
#
# Some extensions requires newer versions of media wiki, refer to
# https://hub.docker.com/_/mediawiki to know the current latest one
#
# In order to download the right one, we use branch_release variable to define
# the branch to clone (see next link)
# https://www.mediawiki.org/wiki/Download_from_Git#Download_a_stable_branch

branch_release=REL1_43

extensions+=SyntaxHighlight_GeSHi
extensions+=InputBox
extensions+=WikiEditor
extensions+=CategoryTree
extensions+=Cite
extensions+=ParserFunctions
extensions+=Math
extensions+=PluggableAuth
extensions+=OpenIDConnect

extensions_targets=$(addprefix wiki/extensions/,${extensions})

.PHONY: all
all: build

.PHONY: dbshell
dbshell:
	docker compose up -d
	docker exec -it wiki-mariadb mariadb wiki

.PHONY: install
install: update

.PHONY: reload
reload:
	docker compose up -d

.PHONY: update
update: build

.PHONY: build
build: ${extensions_targets}
	docker compose up -d --force-recreate
	sleep 5  # wait for db to start
	docker exec -it mediawiki ./maintenance/run update --quick
	docker exec -it mediawiki apt update
	docker exec -it mediawiki apt install unzip
	docker exec -it mediawiki ./getcomposer.sh
	docker exec -it mediawiki composer install

wiki/extensions/%:
	@mkdir -p $(dir $@)
	git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/$* --branch ${branch_release} $@

.PHONY: clean
clean:
	docker compose down
	rm -rf mariadb wiki/extensions .build
