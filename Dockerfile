FROM --platform=linux/amd64 rocker/shiny:latest

LABEL maintainer="Gibran Hemani g.hemani@bristol.ac.uk"
# Based on https://github.com/rocker-org/shiny

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean


COPY . ./app
## renv.lock file
COPY ./renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore(repos = c("https://mrcieu.r-universe.dev/bin/linux/jammy/4.3/", "https://packagemanager.posit.co/cran/__linux__/jammy/latest", "https://cloud.r-project.org"))'

ARG CACHE_DATE
RUN sudo su - -c "R -e \"remotes::install_github('explodecomputer/alspac', repos = c('https://mrcieu.r-universe.dev/bin/linux/jammy/4.3/', 'https://packagemanager.posit.co/cran/__linux__/jammy/latest', 'https://cloud.r-project.org'))\""

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
