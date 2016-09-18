# Setup environment

All services should be self-contained, you don't need to install any additional software other than Docker.

## Install Docker

Installation instructions: https://docs.docker.com/engine/installation/

## Install docker-compose

Installation instructions: https://docs.docker.com/compose/install/

## Install rocker and rocker-compose

https://github.com/grammarly/rocker
https://github.com/grammarly/rocker-compose

## Configure environment variables

Copy example environment files:

    cp env/common.env.sample env/common.env
    cp env/development.env.sample env/development.env

Update them accordingly.

## Build base images

Run the following command to build base images

    bin/build.sh

## Build all containers

Run the following command to create required docker volumes and build all containers:

    bin/bootstrap.sh

## Deploy the app

Run

    bin/deploy.sh

Now the app should be app and running and available by `https://lvh.me`
