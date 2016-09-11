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
  (cd engine && git pull > /dev/null)
  (cd test-runner && git pull > /dev/null)
fi

echo "*** Building docker images"
bin/build.sh
$CONTROL_CMD build > /dev/null

echo '*** Precompiling assets, hold on'
$CONTROL_CMD run --rm -u root rails /bin/bash -c 'bundle exec rake assets:precompile && cp -rf /app/public/* /assets-volume/ && chmod -R a+r /assets-volume/'
$CONTROL_CMD run --rm -u root sample-app /bin/bash -c 'cp -rf /app/public/* /assets-volume/ && chmod -R a+r /assets-volume/'

echo '*** Running migration and seeding'
$CONTROL_CMD run --rm rails bundle exec rake db:migrate db:seed > /dev/null

$CONTROL_CMD up -d

if [ "$LOCAL" = false ]; then
  echo '*** Notifying Rollbar about deployment'
  bin/notify-rollbar.sh
fi
