#! /bin/bash

TIMESTAMP=$(date +%Y.%m.%d.%H%M%S)
mongod --dbpath ../Project_Wiki_Data/db --logpath ../Project_Wiki_Data/log/mongo_${TIMESTAMP}.log --auth --fork
gunicorn -w 2 -b 127.0.0.1:31415 --daemon --pid ../Project_Wiki_Data/gunicorn.pid --access-logfile ../Project_Wiki_Data/log/gunicorn_${TIMESTAMP}.log manage:app
nohup caddy -conf Caddyfile &>/dev/null &
echo "Project Wiki Started"