#!/bin/sh

set -e

OUTPUT_DIR=$1/result
mkdir -p $OUTPUT_DIR

docker run --rm \
  --link qainstructor_selenium-server_1:selenium-server \
  -v $1:/suite/features/user \
  -e SELENIUM_URL=$SELENIUM_URL -e SELENIUM_SESSION_ID=$SELENIUM_SESSION_ID \
  qainstructor/test-runner \
  bin/verify.sh > $OUTPUT_DIR/output.html
