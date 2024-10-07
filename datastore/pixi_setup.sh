#!/bin/bash
set -e

# Wait for MongoDB to start
sleep 5

# Restore the Pixi database
mongorestore --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin --db=Pixidb /backup/PixiDbDump/Pixidb

# Create a read-write user for the Pixi database
mongo admin -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin --eval "db.getSiblingDB('Pixidb').createUser({user: 'pixiuser', pwd: 'devuserXXX', roles: [{role: 'readWrite', db: 'Pixidb'}]})"