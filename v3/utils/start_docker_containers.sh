#!/bin/bash

# Start all Docker containers
docker start $(docker ps -a -q)
