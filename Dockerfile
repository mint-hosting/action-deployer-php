FROM php:7.4-cli-alpine

LABEL "repository" = "https://github.com/mint-hosting/action-deployer-php"
LABEL "homepage" = "https://github.com/mint-hosting/action-deployer-php"

LABEL "com.github.actions.name"="Action - Deployer php"
LABEL "com.github.actions.description"="Use your Deployer PHP script with your github action workflow."
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="yellow"

ENV DEPLOYER_VERSION=6.8.0

RUN apk update --no-cache \
    && apk add --no-cache \
    bash \
    openssh-client \
    rsync \
    nodejs \
    npm

# Change default shell to bash (needed for conveniently adding an ssh key)
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN curl -L https://deployer.org/releases/v$DEPLOYER_VERSION/deployer.phar > /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

RUN curl -L https://getcomposer.org/composer-stable.phar > /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer 

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
