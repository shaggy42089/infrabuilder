#!/bin/bash

read -p "database name :" DB_NAME

read -p "master password [i love lasagna]:" M_PWD
M_PWD=${M_PWD:-i love lasagna}

read -p "slave password [i love spaghetti]:" S_PWD
S_PWD=${S_PWD:-i love spaghetti} 

read -p "port [9009]:" DB_P
DB_P=${DB_P:-9009}

echo "CREATE USER slave_$DB_NAME WITH PASSWORD '$S_PWD';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO slave_$DB_NAME;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO slave_$DB_NAME;
ALTER DEFAULT PRIVILEGES FOR ROLE master_$DB_NAME IN SCHEMA public
GRANT SELECT, DELETE, UPDATE ON TABLES TO slave_$DB_NAME;" > init.sql

# builds the container, this is a necessary step 
# because the variables change from one execution to another
# Be careful not to have 2 containers trying to 
# map their port 5432 to the same outside port
docker build -t infrabuilder-postgresql-$DB_NAME .

docker run -d -p "$DB_P":5432 \
  --name "infrabuilder-postgresql-$DB_NAME" \
  -e POSTGRES_DB="$DB_NAME" \
  -e POSTGRES_USER="master_$DB_NAME" \
  -e POSTGRES_PASSWORD="$M_PWD" \
  "infrabuilder-postgresql-$DB_NAME"
