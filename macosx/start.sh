#! /bin/bash

cd ..
TIMESTAMP=$(date +%Y.%m.%d.%H%M%S)

# start mongodb
mongod --dbpath ../Project_Wiki_Data/db --logpath ../Project_Wiki_Data/log/mongo_${TIMESTAMP}.log --auth --fork

# start web app
gunicorn -w 2 -b 127.0.0.1:31415 --daemon --pid ../Project_Wiki_Data/gunicorn.pid --access-logfile ../Project_Wiki_Data/log/gunicorn_${TIMESTAMP}.log manage:app

# start caddy
nohup caddy -conf Caddyfile &>/dev/null &

echo "Project Wiki Started"