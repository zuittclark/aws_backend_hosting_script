#!/bin/bash

for i in {1..15}; do
    repo="git@ec2-54-147-90-61.compute-1.amazonaws.com:jerry.cabuntucan/csp2-bootcamper$i.git"
    port=$((4000 + i))
    ./deploy.sh "$repo" "$port"
done
