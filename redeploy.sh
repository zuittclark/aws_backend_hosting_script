#!/bin/bash

echo "Pulling changes from repo..."
git pull
echo "====================================="

echo "Restarting pm2 services..."
pm2 restart all

echo "====================================="
echo "Changes successfully deployed!"