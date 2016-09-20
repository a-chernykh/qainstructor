#!/bin/bash

export PGUSER=postgres
psql <<- EOSQL
    CREATE USER engine WITH PASSWORD '$ENGINE_POSTGRES_PASSWORD';
    ALTER USER engine CREATEDB;
EOSQL
