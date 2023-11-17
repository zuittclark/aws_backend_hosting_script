#!/bin/bash -e

# Check if the number of command-line arguments is 1 (bc value)
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bc>"
    exit 1
fi

bc="$1"

echo -e "Setting up production environment for bootcamper$bc"

echo -e "\n==================================="
echo -e "INSTALLING NODEJS VERSION 20.9.0..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.nvm/nvm.sh
# nvm install 16.16.0 
# nvm use 16.16.0 
nvm install 20.9.0 
nvm use 20.9.0 
node -v

echo -e "\n===================================="
echo -e "INSTALLING EXPRESSJS PROJECT DEPENDENCIES..."
npm install || { echo "Error installing npm dependencies"; exit 1; }
echo -e "~> Dependencies installed successfully!"

echo -e "\n===================================="
echo -e "SETTING UP REDEPLOYMENT SCRIPT..."
git clone --depth=1 https://github.com/zuittclark/aws_backend_hosting_script.git --branch=master --single-branch temp || { echo "Error cloning"; exit 1; }
mv temp/v2.1/bc/redeploy.sh ~/ && rm -rf temp 
chmod +x ~/redeploy.sh
echo -e "~> Done setting up redeployment script!"


echo -e "\n===================================="
echo -e "INITIALIZING PM2 SERVICE..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node || { echo "Error starting PM2 service"; exit 1; }
echo -e "~> Done adding pm2 service!"



echo -e "\n===================================="
echo -e "ADDING SERVICE TO CRONTAB..."
current_dir="$PWD"
#This updated command removes duplication of the cron command on multiple execution of the script
cron_command="@reboot sh -c 'cd $current_dir && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'"
{ echo "$cron_command"; } | crontab - || { echo "Error overwriting crontab"; exit 1; }
echo "~> Updated crontab successfully!"
crontab -l

echo -e "\n~> Setup script executed successfully!"
echo -e "\n=================================================="
echo -e "Congratulations!"
echo -e "You have successfully deployed your Backend API."
echo -e "=================================================="
