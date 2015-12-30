#!/bin/bash

set -e

bundle check || bundle install
bundle exec puma -e production -b tcp://0.0.0.0:8080
