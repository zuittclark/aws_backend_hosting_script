#!/bin/bash -e


echo "Setting up production environment for Webhook Handler Server"
echo "==================================="

echo "INSTALLING NODEJS VERSION 16.16.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 20.9.0 
nvm use 20.9.0 
node -v

echo -e "\n===================================="
echo -e "INSTALLING WEBHOOK SERVER..."
git clone --depth=1 https://github.com/zuittclark/aws_backend_hosting_script.git --branch=master --single-branch temp || { echo "Error cloning"; exit 1; }
mv temp/v2.1/inst/webhook webhookServer && rm -rf temp 
cd webhookServer
pwd
npm install || { echo "Error installing npm dependencies"; exit 1; }
echo -e "~> Webhook installed successfully!"

echo -e "===================================="
echo -e "INITIALIZING PM2 SERVICE..."
pwd
pm2 start webHookServer.js --name webhook-server --interpreter ~/.nvm/versions/node/v20.9.0/bin/node || { echo "Error starting PM2 service"; exit 1; }
echo "~> Done adding pm2 service!"

echo -e "===================================="
echo -e "ADDING SERVICE TO CRONTAB..."
current_dir="$PWD"
#This updated command removes duplication of the cron command on multiple execution of the script
cron_command="@reboot sh -c 'cd $current_dir && pm2 start webHookServer.js --name webhook-server --interpreter ~/.nvm/versions/node/v20.9.0/bin/node'"
{ echo "$cron_command"; } | crontab - || { echo "Error overwriting crontab"; exit 1; }
echo "~> Updated crontab successfully!"
crontab -l

echo -e "\n~> Setup script executed successfully!"
echo -e "\n=================================================="
echo -e "Congratulations!"
echo -e "You have successfully deployed the Webhook Server."
echo -e "=================================================="

