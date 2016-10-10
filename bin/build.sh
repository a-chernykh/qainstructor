#!/bin/bash

set -e

for container in ruby backup faye nginx postgres test-runner engine sample-app
do
  echo "Building $container"
  $(cd $container; rocker build . --push > /dev/null)
done
