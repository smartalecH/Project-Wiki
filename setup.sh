#! /bin/bash

if [ $# -ne 2 ]; then
    echo "You must provide 2 arguments as database username and password."
    exit 1
fi

# create data directories
mkdir -p ../Project_Wiki_Data/db ../Project_Wiki_Data/log ../Project_Wiki_Data/uploads

# mongod launched in background
mongod --dbpath ../Project_Wiki_Data/db --logpath ../Project_Wiki_Data/log/mongo_setup.log --auth --fork

# wait for mongod to start
sleep 3

# create admin account for database
mongo admin --eval "db.createUser({user: '$1', pwd: '$2', roles:[{role:'root',db:'admin'}]});"

# install python libraries
pip install -r requirements.txt

# create an super admin account to manage Project Wiki
python manage.py create_admin

# kill mongod process
kill -9 `ps -ef | grep mongod | grep -v grep | awk '{print $2}'`
