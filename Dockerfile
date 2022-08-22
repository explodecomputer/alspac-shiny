FROM rocker/shiny-verse

# Based on https://github.com/rocker-org/shiny

MAINTAINER Gibran Hemani "g.hemani@bristol.ac.uk"

RUN R -e "install.packages(c('shinyBS', 'shinyLP', 'shinythemes', 'DT'), repos='https://cran.rstudio.com/')"


RUN rm -r /srv/shiny-server/*
RUN mkdir -p /srv/shiny-server/
COPY . /srv/shiny-server/



ARG CACHE_DATE
RUN sudo su - -c "R -e \"remotes::install_github('explodecomputer/alspac')\""
