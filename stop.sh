#! /bin/bash

kill -9 `ps -ef | grep gunicorn | grep -v grep | awk '{print $2}'`
kill -9 `ps -ef | grep mongod | grep -v grep | awk '{print $2}'`
kill -9 `ps -ef | grep caddy | grep -v grep | awk '{print $2}'`
echo "Project Wiki Stopped"