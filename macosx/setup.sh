#! /bin/bash

cd ..

echo "Type database username followed by [ENTER]:"
# prompt for input
read username

echo "Type database password followed by [ENTER]:"
# prompt for input
read password

# create data directories
mkdir -p ../Project_Wiki_Data/db ../Project_Wiki_Data/log ../Project_Wiki_Data/uploads

# mongod launched in background
mongod --dbpath ../Project_Wiki_Data/db --logpath ../Project_Wiki_Data/log/mongo_setup.log --auth --fork

# wait for mongod to start
sleep 3

# create admin account for database
mongo admin --eval "db.createUser({user: '$username', pwd: '$password', roles:[{role:'root',db:'admin'}]});"

# install python libraries
pip install -r macosx/requirements.txt

# create an super admin account to manage Project Wiki
python manage.py create_admin

# kill mongod process
kill -9 `ps -ef | grep mongod | grep -v grep | awk '{print $2}'`
