#!/bin/sh

set -e

docker stop sample-app
docker rm sample-app
docker run --name sample-app -d -p 4567:4567 qa-courses/sample-app
