#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt-get install curl
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install nodejs
npm install 
npm run dev