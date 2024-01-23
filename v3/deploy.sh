#!/bin/bash
# Check if the number of command-line arguments is 2 (repo and port)
if [ $# -ne 2 ]; then
    echo "Usage: $0 <repo_url> <port>"
    exit 1
fi

repo_url="$1"
port="$2"

#to get folder name from repo url
folder_name=$(basename "$repo_url" .git)

echo $folder_name
echo $port

echo "*** Cloning git repo... ***"
git clone $repo_url || { echo "Error cloning repo."; exit 1; }
cd $folder_name
pwd
echo "Done!"

echo -e "\n======================================================="
echo "PROVISIONING DOCKER INSTANCE AND DEPLOYING THE APP..."
echo -e "=======================================================\n"

echo "*** Setting up docker file... ***"
cp ~/utils/Dockerfile Dockerfile
cp ~/utils/.dockerignore .dockerignore
echo "Done!"

echo "*** Building docker image... ***"
docker build -t $folder_name . || { echo "Error building image"; exit 1; }
echo "Done!"

echo "*** Deploying docker container from image... ***"
docker run --name "$folder_name"_c -p $port:4000 -d -v $PWD:/app -v /app/node_modules $folder_name || { echo "Error running container instance."; exit 1; }
echo "Done!"

echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++"
echo "API successfully deployed to docker with contaner name "$folder_name"_c !"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++\n"