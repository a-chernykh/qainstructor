#!/bin/bash

set -e

docker run -d -p 5000:5000 \
  --restart=always \
	--name=registry \
  -v `pwd`/config.yml:/etc/docker/registry/config.yml \
  -v `pwd`/htpasswd:/etc/docker/registry/htpasswd \
	registry:2
