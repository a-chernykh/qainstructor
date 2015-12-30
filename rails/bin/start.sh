#!/bin/bash

set -e

bundle check || bundle install
bundle exec rails server -b 0.0.0.0 -p 8080
