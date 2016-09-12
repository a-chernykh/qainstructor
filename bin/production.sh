#!/bin/bash

docker-compose -p qainstructor -f docker-compose.yml -f docker-compose.production.yml "$@"
