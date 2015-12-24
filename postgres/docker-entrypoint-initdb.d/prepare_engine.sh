#!/bin/bash

export PGUSER=postgres
psql <<- EOSQL
    CREATE USER engine WITH PASSWORD '$ENGINE_POSTGRES_PASSWORD';
    CREATE DATABASE engine;
    CREATE DATABASE engine_test;
    GRANT ALL PRIVILEGES ON DATABASE engine TO engine;
    GRANT ALL PRIVILEGES ON DATABASE engine_test TO engine;
EOSQL
