#!/bin/bash

# Check if the number of command-line arguments is 1 (bc value)
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bc>"
    exit 1
fi

bc="$1"

echo "Setting up for bootcamper$bc"

echo "==================================="
echo "Installing Node version 16.16.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 16.16.0
nvm use 16.16.0
node -v

echo "===================================="
echo "Installing project dependencies..."
npm install
echo "Dependencies installed successfully!"

echo "===================================="
echo "Adding pm2 service..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node
echo "Done adding pm2 service!"

echo "===================================="
echo "Adding service to crontab..."
repo_name=$(basename "$PWD")
(crontab -l 2>/dev/null; echo "@reboot sh -c 'cd /home/bootcamper$bc/$repo_name && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'") | crontab -
echo "Added service to crontab!"
crontab -l

echo "===================================="
echo "Setup script executed successfully!"