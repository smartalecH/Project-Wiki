@echo off

:: stop MongoDB service
net stop MongoDB

:: stop server
taskkill /IM pythonw.exe /f

echo Server stopped
sleep 1