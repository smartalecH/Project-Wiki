#! /bin/bash

cd ..
wikidir=$PWD
cd ..

# create data directories
if [ ! -d "Project_Wiki_Data" ]; then
  mkdir Project_Wiki_Data
  cd Project_Wiki_Data
  mkdir db log uploads
  echo "Project_Wiki_Data created"
else
  echo "Project_Wiki_Data already exists"
  echo "Move it somewhere else. Then run this script again."
  exit 1
fi

# echo "Type database username followed by [ENTER]:"
# # prompt for input
# read username
#
# echo "Type database password followed by [ENTER]:"
# # prompt for input
# read password

# mongod launched in background
mongod --dbpath ./Project_Wiki_Data/db --logpath ./Project_Wiki_Data/log/mongo_setup.log --auth --fork

# wait for mongod to start
sleep 3

# create admin account for database
mongo admin --eval "db.createUser({user: '$1', pwd: '$2', roles:[{role:'root',db:'admin'}]});"

cd $wikidir

# install python libraries
pip install -r macosx/requirements.txt

# create an super admin account to manage Project Wiki
python manage.py create_admin

# kill mongod process
kill -9 `ps -ef | grep mongod | grep -v grep | awk '{print $2}'`
