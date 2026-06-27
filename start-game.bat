@echo off
title Jungle War Chess
echo Starting Jungle War Chess...
cd /d "%~dp0"
start "" "http://localhost:8423"
npx -y http-server -p 8423 -c-1 .
