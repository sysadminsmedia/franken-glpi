![GLPI Logo](https://raw.githubusercontent.com/glpi-project/glpi/master/pics/logos/logo-GLPI-250-black.png)

# GLPI Franken PHP Containers
Manifest files for build and deploy the **GLPI** as Containers with Docker and Franken PHP using docker-compose.

This version can handle a significant number of users, with extremely low page loading times and overall operates extremely well.

Additionally, this version comes build and prepared to run straight out the box with cron jobs and redis caching, just copy the .env.example file to .env, setup the passwords and secrets, and launch with `docker compose up -d`.

Original Inspiration: https://github.com/eftechcombr/glpi

## Credentials
    username: glpi
    password: glpi

## Variables

### docker-compose 

    .env.example ---> please rename to .env

## About GLPI

GLPI stands for **Gestionnaire Libre de Parc Informatique** is a Free Asset and IT Management Software package, that provides ITIL Service Desk features, licenses tracking and software auditing.

https://github.com/glpi-project/glpi


## License

![license](https://img.shields.io/github/license/glpi-project/glpi.svg)
