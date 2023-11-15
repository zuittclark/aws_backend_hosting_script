# AWS Bootcamper Instance Setup Script
#### The goal of this script is to automate the process of setting up the bootcampers user instance to minimize configuration steps

Example command:
```bash
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1
```

`Created by CLRK`


```bash
# ================
# INSTRUCTOR SIDE
# ================
#============================================================
#- For auto setup
https://zuittclark.github.io/script-generator-cpst2Hosting/
# importing script manually
scp -i ~/.ssh/zuitt_keypair_us_east2.pem instructor_script.sh ubuntu@ec2-18-189-109-12.us-east-2.compute.amazonaws.com:~/
#============================================================
```
### Add bootcamper server to nginx (This still need to be done manually)
```bash
sudo nano /etc/nginx/sites-available/default
```
### add the ff under the "server_name_;" block:
```bash
        location /webhook {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4100;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b1 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4001;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b2 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4002;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b3 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4003;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
        location /b4 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4004;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b5 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4005;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b6 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4006;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b7 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4007;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b8 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4008;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b9 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4009;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location /b10 {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            proxy_pass http://localhost:4010;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
```
### Restarting nginx service
```bash
sudo systemctl restart nginx
sudo systemctl status nginx
```

### Install Webhook Handler Server for Auto deploy
```bash
curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/v2.1/inst/installWebhookServer.sh | bash
```


### To delete user
```bash
sudo pkill -u bootcamper#
sudo userdel -r bootcamper#

```
### To delete all users
```bash
for i in {1..10}; do
    # Kill processes associated with the user
    sudo pkill -u bootcamper$i
done
```
```bash
for i in {1..10}; do
    # Delete the user along with the home directory
    sudo userdel -r bootcamper$i
done
```

### Check if the user is deleted
```sh
less /etc/passwd | grep bootcamper
```

### Other stuff
```bash
num=1
rm -rf node_modules/ webhook/ && pm2 stop all && pm2 delete b$num && pm2 delete webhook-server$num && crontab -r
rm -rf node_modules/ && crontab -r
``` 

## BOOTCAMPER SIDE SETUP
```bash
#================
#BOOTCAMPER SIDE
#================
#- ssh to server
ssh -o ServerAliveInterval=60 bootcamper1@ec2-18-189-109-12.us-east-2.compute.amazonaws.com

# AUTO SETUP (v1)

    # Deploy script
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/setup.sh | bash -s -- 1
    # Note: the 1 arg after the -- pertains to the bootcamper number

    #REDEPLOY CHANGES SCRIPT 
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/redeploy.sh | bash

# AUTO SETUP (v2)
    # Generate SSH Key
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/v2/sshkeygen.sh | bash

    # Deploy script
    curl -sSf https://raw.githubusercontent.com/zuittclark/aws_backend_hosting_script/master/v2/setup_v2.sh | bash -s -- 1
    # Note: the 1 arg after the -- pertains to the bootcamper number

# MANUAL SETUP
    #- Setup node version (select only one of the ff)
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
        #alternatives:
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
            curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install 16.16.0
    nvm use 16.16.0

    #- Clone CSP2 repo

    #- install dependencies
    npm install

    #- Add to pm2
    pm2 start index.js --name b1 --interpreter ~/.nvm/versions/node/v16.16.0/bin/node

    #- Create a cron job (to run the server on boot)
    crontab -e #select 1 for nano editor 
        #Add the ff:
            @reboot sh -c 'cd /home/bootcamper1/app && pm2 start index.js --name b1 --interpreter ~/.nvm/versions/node/v16.16.0/bin/node'
    crontab -l #to check


```