#!/bin/bash

echo "What is your bootcamper number?"
read bc # Replace this with your desired value for bc

echo "Setting up for bootcamper$bc"
echo "=================================="
echo "Installing Node version 16.16.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

source ~/.nvm/nvm.sh
nvm install 16.16.0
nvm use 16.16.0
node -v
echo "============================="

echo "Installing project dependencies..."
cd .. && npm install
echo "Dependencies installed successfully!"

echo "===================================="
echo "Adding service to crontab..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node

(crontab -l 2>/dev/null; echo "@reboot sh -c 'cd /home/bootcamper$bc/app && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'") | crontab -


echo "Added service to crontab!"
crontab -l
echo "===================================="
echo "Setup script executed successfully!"