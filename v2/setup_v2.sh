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
echo "INSTALLING WEBHOOK FOR DEPLOYMENTS..."
git clone --depth=1 https://github.com/zuittclark/aws_backend_hosting_script.git --branch=master --single-branch v2-temp || { echo "Error cloning"; exit 1; }
mv v2-temp/v2/webhook webhook && rm -rf v2-temp 
echo "~> Web Hook installed successfully!"

echo "\n===================================="
echo "INITIALIZING PM2 SERVICE..."
echo "starting project server..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node || { echo "Error starting PM2 service for project server"; exit 1; }
echo "starting project server DONE!"
echo "\nstarting web hook server..."
pm2 start webhook/webHookServer.js --name "webhook-server$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node -- $bc || { echo "Error starting PM2 service for webhook server"; exit 1; }
echo "starting web hook server DONE!"
echo "~> Done adding pm2 service!"

echo "\n===================================="
echo "ADDING SERVICE TO CRONTAB..."
current_dir="$PWD"
#This updated command removes duplication of the cron command on multiple execution of the script
cron_command1="@reboot sh -c 'cd $current_dir && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'"
cron_command2="@reboot sh -c 'cd $current_dir && pm2 start webhook/webHookServer.js --name webhook-server --interpreter ~/.nvm/versions/node/v16.16.0/bin/node -- $bc'"

{ echo "$cron_command1\n$cron_command2"; } | crontab - || { echo "Error overwriting crontab"; exit 1; }

echo "~> Updated crontab successfully!"
crontab -l
echo "\n~> Setup script executed successfully!"
echo "\n==================================================================="
echo "Congratulations! You have successfully deployed your Backend API."
echo "==================================================================="
