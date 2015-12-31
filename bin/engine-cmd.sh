#!/bin/bash

set -e

bin/production.sh run --rm engine "$@"
