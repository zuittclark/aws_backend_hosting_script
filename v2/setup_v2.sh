#!/bin/bash -e

# Check if the number of command-line arguments is 1 (bc value)
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bc>"
    exit 1
fi

bc="$1"

echo "Setting up production environment for bootcamper$bc"
echo "\n==================================="
echo "INSTALLING NODEJS VERSION 16.16.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 16.16.0 
nvm use 16.16.0 
node -v

echo "\n===================================="
echo "INSTALLING EXPRESSJS PROJECT DEPENDENCIES..."
npm install || { echo "Error installing npm dependencies"; exit 1; }
echo "~> Dependencies installed successfully!"

echo "\n===================================="
echo "INITIALIZING PM2 SERVICE..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node || { echo "Error starting PM2 service"; exit 1; }
echo "~> Done adding pm2 service!"

echo "\n===================================="
echo "ADDING SERVICE TO CRONTAB..."
current_dir="$PWD"
#This updated command removes duplication of the cron command on multiple execution of the script
cron_command="@reboot sh -c 'cd $current_dir && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'"
{ echo "$cron_command"; } | crontab - || { echo "Error overwriting crontab"; exit 1; }
echo "~> Updated crontab successfully!"
crontab -l

echo "\n===================================="
echo "~> Setup script executed successfully!"
echo "===================================="
