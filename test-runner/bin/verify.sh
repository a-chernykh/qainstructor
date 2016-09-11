#!/bin/bash

touch /tmp/lastrun

JOB_TOKEN=$1
export SELENIUM_URL=$2
export SELENIUM_SESSION_ID=$3

HOST_JOB_DIR=/jobs/$JOB_TOKEN
LOCAL_JOB_DIR=/job/$JOB_TOKEN
OUTPUT_DIR=$HOST_JOB_DIR/result

mkdir -p $OUTPUT_DIR

mkdir -p $LOCAL_JOB_DIR/features/user
cp -rf $HOST_JOB_DIR/* $LOCAL_JOB_DIR/features/user
cp -rf /suite/* $LOCAL_JOB_DIR/
cd $LOCAL_JOB_DIR

bundle exec cucumber -t ~@expected-to-fail --strict --format html > output1.html
rc=$?
if [[ $rc != 0 ]]; then
  mv output1.html $OUTPUT_DIR/output.html
  exit 1
fi

if [ -f features/user/failing_scenario.feature ]; then
  bundle exec cucumber -t @expected-to-fail --strict --format html > output2.html
  rc=$?
  if [[ $rc != 0 ]]; then
    mv output1.html $OUTPUT_DIR/output.html
    exit 0
  else
    mv output2.html $OUTPUT_DIR/output.html
    exit 1
  fi
fi
