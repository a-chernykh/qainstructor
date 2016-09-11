#!/bin/bash

# Builds base containers

set -e

for container in ruby test-runner engine
do
  echo "Building $container"
  $(cd $container; bin/build.sh > /dev/null)
done
