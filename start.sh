#!/bin/bash

set -e

DNS=`ipconfig getifaddr en0`
sed -i '' "s/dns: .*/dns: $DNS/" docker-compose.yml
docker-compose up -d
