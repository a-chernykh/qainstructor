#!/bin/bash

set -e

echo "export PGPASSWORD=$POSTGRES_ENV_POSTGRES_PASSWORD" > /etc/env
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> /etc/env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> /etc/env

chmod 0600 /etc/env

cron

tail -f /var/log/cron.log
