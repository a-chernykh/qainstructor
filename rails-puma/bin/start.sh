#!/bin/bash

set -e

bundle check || bundle install
bundle exec puma -C puma.rb
