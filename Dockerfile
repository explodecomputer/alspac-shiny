FROM r-base:latest

MAINTAINER Winston Chang "winston@rstudio.com"

# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev

RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb

RUN R -e "install.packages(c('shiny', 'rmarkdown', 'dplyr', 'ghit', 'shinyBS', 'shinyLP', 'shinythemes', ), repos='https://cran.rstudio.com/')"

# RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    rm -rf /var/lib/apt/lists/*

RUN sudo su - -c "R -e \"install.packages(c('ghit','shiny','rmarkdown','tidyverse','rgeos','rgdal'))\""
RUN sudo su - -c "R -e \"ghit::install_github('explodecomputer/alspac')\""
RUN sudo su - -c "R -e \"ghit::install_github('rstudio/DT')\"" 
RUN sudo su - -c "R -e \"ghit::install_github('explodecomputer/shinyTypeahead')\"" 


EXPOSE 3838

RUN rm -r /srv/shiny-server/*
RUN mkdir -p /srv/shiny-server/
COPY . /srv/shiny-server/

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]