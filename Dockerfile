FROM --platform=linux/amd64 rocker/shiny:latest

LABEL maintainer="Gibran Hemani g.hemani@bristol.ac.uk"
# Based on https://github.com/rocker-org/shiny

RUN apt-get update && \
    apt-get install -yyy \
        build-essential \
        libsqlite3-dev \
        libmariadbd-dev \
        libpq-dev \
        libssh2-1-dev \
        libcurl4-gnutls-dev \
        libcurl4-openssl-dev \
        unixodbc-dev \
        libxml2-dev \
        libssl-dev \
        libgmp3-dev \
        cmake \
        libcairo2-dev \
        libxt-dev \
        libharfbuzz-dev \
        libtiff-dev \
        libzstd-dev \
        git \
        libgit2-dev \
        libfribidi-dev \
        wget && \
        wget https://launchpad.net/ubuntu/+source/icu/70.1-2/+build/23145450/+files/libicu70_70.1-2_amd64.deb && \
        dpkg -i libicu70_70.1-2_amd64.deb && \
        ln -s /usr/lib/x86_64-linux-gnu/libgit2.so.1.7 /usr/lib/x86_64-linux-gnu/libgit2.so.1.1


## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean


COPY . ./app
## renv.lock file
COPY ./renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("renv", repos = "https://packagemanager.posit.co/cran/__linux__/jammy/latest")'
RUN Rscript -e 'renv::restore(repos = c("https://packagemanager.posit.co/cran/__linux__/jammy/latest", "https://cloud.r-project.org"))'

ARG CACHE_DATE
RUN sudo su - -c "R -e \"remotes::install_github('explodecomputer/alspac', repos = c('https://mrcieu.r-universe.dev/bin/linux/jammy/4.3/', 'https://packagemanager.posit.co/cran/__linux__/jammy/latest', 'https://cloud.r-project.org'))\""

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
