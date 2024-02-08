FROM rocker/shiny-verse

LABEL maintainer="Gibran Hemani g.hemani@bristol.ac.uk"
# Based on https://github.com/rocker-org/shiny

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get install -y gcc gcc-4.9. && \
    apt-get upgrade -y libstdc++6 && \
    apt-get -y dist-upgrade

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
