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
(cd test-runner && git pull)

$CONTROL_CMD build test-runner
$CONTROL_CMD build engine
$CONTROL_CMD build rails
$CONTROL_CMD build sidekiq

bin/engine-cmd.sh bundle install

echo 'Precompiling assets, hold on'
# assepts:precompile tries to connect to DB, that's why we need to link with PG
# https://github.com/rails/rails/issues/11853
docker run --link qainstructor_postgres_1:postgres --rm --env-file=env/common.env --env-file=env/production.env -it -v bundle:/bundle -v production-assets:/app/public $DOCKER_RUN_ARGS qainstructor_engine bundle exec rake assets:precompile
docker run --rm -v production-assets:/assets $DOCKER_RUN_ARGS qainstructor_engine /bin/bash -c 'cp -rf /app/public/* /assets/'

echo 'Running migration and seeding'
$CONTROL_CMD run --rm $DOCKER_RUN_ARGS rails bundle exec rake db:migrate db:seed

$CONTROL_CMD up --no-deps -d rails
$CONTROL_CMD up --no-deps -d sidekiq
$CONTROL_CMD up --no-deps -d nginx

bin/notify-rollbar.sh
