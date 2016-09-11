#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker-compose -f $DIR/../docker-compose.yml -f $DIR/../docker-compose.development.yml "$@"
