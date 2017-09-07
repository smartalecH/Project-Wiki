#! /bin/bash

cd ..
TIMESTAMP=$(date +%Y.%m.%d.%H%M%S)

# start mongodb
mongod --dbpath ../Project_Wiki_Data/db --logpath ../Project_Wiki_Data/log/mongo_${TIMESTAMP}.log --auth --fork

echo "MongoDB Started"