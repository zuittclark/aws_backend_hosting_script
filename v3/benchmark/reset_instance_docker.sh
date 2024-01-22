#Deletes containers
docker rm -vf $(docker ps -aq)
#Deletes images
docker rmi -f $(docker images -aq)
#Deletes project folders
for i in {1..15}; do
    folder="csp2-bootcamper$i"
    if [ -d "$folder" ]; then
        echo "Deleting $folder"
        rm -rf "$folder"
    else
        echo "Folder $folder not found"
    fi
done
#Deletes cache
docker system prune --volumes -af