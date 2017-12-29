#!/bin/bash

set -ex

## See https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54

# ensure we're up to date
git pull

# bump version
version=`cat version.txt | cut -d " " -f 1`
echo "version: $version"

# run build
docker build -t alspac-shiny:latest .

# run container
docker stop alspac-shiny || true
docker rm alspac-shiny || true
docker run -d --name alspac-shiny -p 8010:3838 --restart=always alspac-shiny:latest
