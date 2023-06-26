<iframe width="560" height="315" src="https://www.youtube.com/embed/HButaBBYxKw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

# Development

## Install software

All services should be self-contained, you don't need to install any additional software other than Docker.

### Install Docker

Installation instructions: https://docs.docker.com/engine/installation/

### Install docker-compose

Installation instructions: https://docs.docker.com/compose/install/

### Install rocker and rocker-compose

https://github.com/grammarly/rocker
https://github.com/grammarly/rocker-compose

## Configure environment variables

Copy example environment files:

    cp env/common.env.sample env/common.env
    cp env/development.env.sample env/development.env

Update them accordingly.

## Login to Docker Registry

Add `qainstructor.com:5043` to the list of insecure registries. And login:

    docker login https://qainstructor.com:5043

## Bootstrap

The following command will create all necessary volumes and database:

    bin/bootstrap.sh

# Run locally

Run
    bin/development.sh up -d

# Build Docker image

To build all images run:

    bin/build.sh

To build one image:

    cd engine
    rocker build . --push

# Deploy the app

Run

    bin/deploy.sh

Now the app should be app and running and available by `https://lvh.me`
