#!/bin/bash

set -ex

## See https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54

# ensure we're up to date
git pull

# bump version
version=`cat version.txt | cut -d " " -f 1`
echo "version: $version"

# run build
docker build -t mrbase-shiny:latest .

# run container
docker stop mrbase-shiny || true
docker rm mrbase-shiny || true
docker run -d --name mrbase-shiny -p 8001:3838 --restart=always mrbase-shiny:latest

# temporarily just run the old image

# docker run -d --name mrbase-shiny -p 8001:3838 --restart=always 182659d3bce1

# This is how tom was running it as a service

# Push the image to the local registry (so all three nodes can access)
#   docker tag mrbase-shiny 127.0.0.1:5000/mrbase-shiny
#   docker push 127.0.0.1:5000/mrbase-shiny
# Create the service. I've forwarded port 8001 to 3838 (arbitrary selection); the 127.0.0.1... is the reference to the image on the registry
#   docker service create --replicas 1 --name mrbase-shiny --publish 8001:3838 127.0.0.1:5000/mrbase-shiny


