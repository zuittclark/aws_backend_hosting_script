#!/bin/bash -e

# Check if the number of command-line arguments is 1 (bc value)
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bc>"
    exit 1
fi

bc="$1"

echo -e "Setting up production environment for bootcamper$bc"
echo -e "\n==================================="
echo -e "INSTALLING NODEJS VERSION 16.16.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 16.16.0 
nvm use 16.16.0 
node -v


echo -e "\n===================================="
echo "INSTALLING EXPRESSJS PROJECT DEPENDENCIES..."
npm install || { echo "Error installing npm dependencies"; exit 1; }
echo "~> Dependencies installed successfully!"

echo -e "\n===================================="
echo -e "INSTALLING WEBHOOK FOR DEPLOYMENTS..."
if [ -d "webhook" ]
then
    echo -e "~> Web Hook already installed. Continuing..."
else
    git clone --depth=1 https://github.com/zuittclark/aws_backend_hosting_script.git --branch=master --single-branch v2-temp || { echo "Error cloning"; exit 1; }
    mv v2-temp/v2/webhook webhook && rm -rf v2-temp 
    chmod +x webhook/deploy.sh
    echo -e "~> Web Hook installed successfully!"
if

echo -e "\n===================================="
echo "INITIALIZING PM2 SERVICE..."
echo "starting project server..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node || { echo "Error starting PM2 service for project server"; exit 1; }
echo -e "starting project server DONE!"
echo -e "\nstarting web hook server..."
pm2 start webhook/webHookServer.js --name "webhook-server$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node -- $bc || { echo "Error starting PM2 service for webhook server"; exit 1; }
echo -e "starting web hook server DONE!"
echo -e "~> Done adding pm2 service!"

echo -e "\n===================================="
echo -e "ADDING SERVICE TO CRONTAB..."
current_dir="$PWD"
#This updated command removes duplication of the cron command on multiple execution of the script
cron_command1="@reboot sh -c 'cd $current_dir && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'"
cron_command2="@reboot sh -c 'cd $current_dir && pm2 start webhook/webHookServer.js --name webhook-server --interpreter ~/.nvm/versions/node/v16.16.0/bin/node -- $bc'"
combined_cron_commands="$cron_command1"$'\n'"$cron_command2"
{ echo "$combined_cron_commands"; } | crontab - || { echo "Error overwriting crontab"; exit 1; }

echo "~> Updated crontab successfully!"
crontab -l
echo -e "\n~> Setup script executed successfully!"
echo -e "\n==================================================================="
echo -e "Congratulations! You have successfully deployed your Backend API."
echo -e "==================================================================="
