# Shiny app for ALSPAC searches

## Updating

There are two parts to updating the website:

### 1. Updating the data dictionary in the `R/alspac` package

Connect to the R drive and clone the alspac R package. Full instructions are found here: [https://github.com/explodecomputer/alspac#package-maintenance](https://github.com/explodecomputer/alspac#package-maintenance)

### 2. Pushing those changes to the web application

If any changes are made to the shiny app then increment the version number by running

```bash
./update_version.sh <1/2/3>
```

The shiny app is deployed as a Docker container on `crashdown.epi.bris.ac.uk`. To update either because of changes to the app or the data dictionary, ssh into the server, clone the repository

```bash
git clone git@github.com:explodecomputer/alspac-shiny.git
```

Then build and deploy

```bash
cd alspac-shiny
./release.sh
```

## Deployment

Every time a commit is pushed to the repo the docker image is rebuilt and pushed to https://hub.docker.com/repository/docker/explodecomputer/alspac-shiny/general.

You can trigger rebuilding (e.g. if the [explodecomputer/alspac](https://github.com/explodecomputer/alspac) package is updated) by going to `Actions`, clicking the most recent job and clicking `Re-run`. 

Then deploy using e.g.:

```
docker run -d \
  --name alspac-shiny \
  -p 8010:3838 \
  --restart=always \
  explodecomputer/alspac-shiny:latest
```

You can setup automatic updates with this:

```
docker run -d \
  --name alspac-shiny-watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  alspac-shiny
```

Notes on CI/CD (not currently working)

- https://gist.github.com/Daniel-ltw/552b90800b07c22e4a83dfa68ada6318
- https://github.com/orgs/community/discussions/26323

### LEGACY: On Shiny server:

```bash
#!/bin/bash

maintenance=${1}

sudo R -e 'devtools::install_github("explodecomputer/alspac")'
sudo R -e 'devtools::install_github("rstudio/DT")'

cd ${HOME}/repo/alspac-shiny

git fetch
git pull
if [[ -n "$maintenance" ]]; then
        echo "deploying maintenance page"
        git checkout maintenance
        git pull
fi
sudo rm -r /srv/shiny-server/alspac/*
sudo cp -r * /srv/shiny-server/alspac/


if [[ -n "$maintenance" ]]; then
        git checkout master
fi

sudo systemctl restart shiny-server
```


## To do

- Separate into Search and Browse
- Add search bar. Use typeahead: [https://github.com/ThomasSiegmund/shinyTypeahead](https://github.com/ThomasSiegmund/shinyTypeahead)
- Search brings up a filtered table based on grep of the searched word
- Filter by tags or categories (lables 1-3)
- Filter by dataset - have an inventory of datasets including their details.
- Link to pdfs

## Notes

### Colours

- http://www.color-hex.com/color/c9002f
- ALSPAC background colour: #c9002f
- Selected colour: #7d001d
- Hover colour: #960023
