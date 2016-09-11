#!/bin/sh

set -e


docker run \
  --dns `ipconfig getifaddr en0` \
  --rm -i -t \
  -e APP_URL=http://app.sample.lvh.me \
  -v `pwd`/test:/suite/features/user \
  qainstructor/test-runner \
  "$@"
