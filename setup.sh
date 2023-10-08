#!/bin/bash

#!/bin/bash

bc=""

while getopts ":b:" opt; do
  case $opt in
    b)
      bc="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$bc" ]; then
  echo "Usage: $0 -b <bc>"
  exit 1
fi

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
npm install
echo "Dependencies installed successfully!"

echo "===================================="
echo "Adding pm2 service..."
pm2 start index.js --name "b$bc" --interpreter ~/.nvm/versions/node/v16.16.0/bin/node
echo "Done adding pm2 service!"
echo "Adding service to crontab..."
(crontab -l 2>/dev/null; echo "@reboot sh -c 'cd /home/bootcamper$bc/app && pm2 start index.js --name b$bc --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'") | crontab -
echo "Added service to crontab!"
crontab -l
echo "===================================="
echo "Setup script executed successfully!"