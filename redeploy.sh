#!/bin/bash

echo "Pulling changes from remote repository..."
git pull
echo "====================================="

echo "Restarting pm2 services..."
pm2 restart all

echo "====================================="
echo "Changes successfully deployed!"