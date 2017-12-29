# Shiny app for ALSPAC searches

## Deployment

### On Docker:

```bash
./release.sh
```


### On Shiny server:

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

Separate into Search and Browse

Add search bar. Use typeahead: [https://github.com/ThomasSiegmund/shinyTypeahead](https://github.com/ThomasSiegmund/shinyTypeahead)

Search brings up a filtered table based on grep of the searched word

Filter by tags or categories (lables 1-3)

Filter by dataset - have an inventory of datasets including their details.

Link to pdfs

