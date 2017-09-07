#! /bin/bash

cd ..
TIMESTAMP=$(date +%Y.%m.%d.%H%M%S)

# start mongodb
mongod --dbpath ../Project_Wiki_Data/db \
    --logpath ../Project_Wiki_Data/log/mongo_${TIMESTAMP}.log \
    --auth \
    --fork

if pgrep -x "mongod" > /dev/null
then
    echo "MongoDB started"
else
    echo "MongoDB fail to start"
fi

# start web app
gunicorn -w 2 -b 127.0.0.1:31415 --daemon \
    --max-requests 200 \
    --pid ../Project_Wiki_Data/gunicorn.pid \
    --access-logfile ../Project_Wiki_Data/log/gunicorn_${TIMESTAMP}.log \
    manage:app

# start caddy
nohup caddy -conf Caddyfile &>/dev/null &


if pgrep -x "caddy" > /dev/null
then
    echo "Caddy started"
else
    echo "Caddy fail to start"
fi


if pgrep -x "mongod" > /dev/null && pgrep -x "caddy" > /dev/null
then
    echo "Project Wiki started"
else
    echo "Project Wiki fail to start"
fi