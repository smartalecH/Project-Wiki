@echo off

:: start MongoDB service
net start MongoDB

:: navigate to Project-Wiki directory
cd %~dp0\..

:: start server
start pythonw run.py

echo Server started

sleep 1
