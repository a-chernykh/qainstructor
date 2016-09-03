#!/bin/bash

set -e

source /etc/env

FILENAME=postgres-backup-`date +%F-%R`.sql

pg_dumpall -h postgres -U postgres -f $FILENAME
gzip $FILENAME
aws s3 cp $FILENAME.gz s3://qa-engine-backups/postgres/$FILENAME.gz
rm -f $FILENAME.gz
