#!/bin/bash

set -e

# number of seconds when container considered idle
IDLE_SECONDS=7200

# flag file (will be touch-ed whenever user runs code
touch /tmp/lastrun

while true; do
  sleep 10;

  NOW=$(date +%s)
  ATIME=$(stat -c "%X" /tmp/lastrun)
  ELAPSED=$((NOW - ATIME))

  if [ "$ELAPSED" -ge "$IDLE_SECONDS" ]
  then
    echo 'Detected idle runner, exiting'
    break
  fi
done
