#!/bin/bash

set -e

DOCKER_RUN_ARGS=""
CONTROL_CMD="bin/production.sh"
PLATFORM=`uname`
if [[ "$PLATFORM" == "Darwin" ]]; then
  DOCKER_RUN_ARGS="--env-file=env/production.local.env"
  CONTROL_CMD="bin/local-production.sh"
fi

git pull
(cd engine && git pull)
$CONTROL_CMD build engine
$CONTROL_CMD build rails
$CONTROL_CMD build sidekiq

bin/engine-cmd.sh bundle install

echo 'Precompiling assets, hold on'
docker run --rm --env-file=env/common.env --env-file=env/production.env -it -v bundle:/bundle -v production-assets:/app/public $DOCKER_RUN_ARGS qainstructor_engine bundle exec rake assets:precompile
docker run --rm -v production-assets:/assets $DOCKER_RUN_ARGS qainstructor_engine /bin/bash -c 'cp -rf /app/public/* /assets/'

$CONTROL_CMD up -d rails
$CONTROL_CMD up -d sidekiq
