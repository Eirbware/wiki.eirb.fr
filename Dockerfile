FROM mediawiki:stable

# unzip is required at some point
RUN apt update && apt install unzip

RUN git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi extensions/SyntaxHighlight_GeSHi || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/InputBox extensions/InputBox || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/WikiEditor extensions/WikiEditor || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/CategoryTree extensions/CategoryTree || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Cite extensions/Cite || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/ParserFunctions extensions/ParserFunctions || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Math extensions/Math || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/PluggableAuth extensions/PluggableAuth || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/OpenIDConnect extensions/OpenIDConnect || true && \
    git clone --branch REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend extensions/MobileFrontend || true

# Need composer to make OpenIDConnect work
COPY wiki/getcomposer.sh wiki/composer.local.json .
RUN ./getcomposer.sh && composer install

COPY wiki/LocalSettings.php .
