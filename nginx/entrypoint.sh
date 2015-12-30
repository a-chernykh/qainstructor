#!/bin/bash

set -e

sed -i 's/\$FAYE_HOST/'$FAYE_HOST'/g; s/\$SAMPLE_APP_HOST/'$SAMPLE_APP_HOST'/g; s/\$ENGINE_HOST/'$ENGINE_HOST'/g;' /etc/nginx/conf.d/default.conf

exec "$@"
