#!/bin/bash

set -e

CONTROL_CMD="bin/production.sh"

PLATFORM=`uname`
if [[ "$PLATFORM" == "Darwin" ]]; then
  LOCAL=true
  CONTROL_CMD="bin/development.sh"
else
  LOCAL=false
fi

if [ "$LOCAL" = false ]; then
  echo "*** Pulling latest changes"
  git pull > /dev/null
fi

echo '*** Pulling containers'
$CONTROL_CMD pull

echo '*** Precompiling assets, hold on'
# First, make sure that qainstructor-engine-assets volume has up to date version of public folder from rails container
docker run --rm -u root -v qainstructor-engine-assets:/assets-volume qainstructor_rails /bin/bash -c 'cp -rf /app/public/* /assets-volume/'
# Next precompile all assets (qainstructor-engine-assets is mounted as /app/public in docker-compose)
$CONTROL_CMD run --rm -u root rails /bin/bash -c 'bundle exec rake assets:precompile && chmod -R a+r /app/public'

$CONTROL_CMD run --rm -u root sample-app /bin/bash -c 'cp -rf /app/public/* /assets-volume/ && chmod -R a+r /assets-volume/'

echo '*** Running migration and seeding'
$CONTROL_CMD run --rm rails bundle exec rake db:migrate db:seed > /dev/null

$CONTROL_CMD up -d

if [ "$LOCAL" = false ]; then
  echo '*** Notifying Rollbar about deployment'
  bin/notify-rollbar.sh
fi
