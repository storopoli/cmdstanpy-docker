FROM python

LABEL maintainer="Jose Storopoli <jose@storopoli.io>" \
  org.opencontainers.image.authors="Jose Storopoli" \
  org.opencontainers.image.url="https://hub.docker.com/repository/docker/jstoropoli/cmdstanr" \
  org.label-schema.vcs-url="https://github.com/storopoli/cmdstanr-docker" \
  org.label-schema.license="MIT"

# env vars
ENV CSVER=2.32.1
ENV CMDSTAN=/opt/cmdstan-$CSVER
ENV PYTHONDONTWRITEBYTECODE=1
RUN useradd -ms /bin/bash user

# install openMPI and MPI's mpicxx binary
RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl libopenmpi-dev mpi-default-dev

# set workdir for /opt/cmdstan-CSVER
WORKDIR /opt/

# download and extract cmdstan based on CSVER from github
RUN curl -OL https://github.com/stan-dev/cmdstan/releases/download/v$CSVER/cmdstan-$CSVER.tar.gz \
  && tar xzf cmdstan-$CSVER.tar.gz \
  && rm -rf cmdstan-$CSVER.tar.gz

# copy the make/local to CMDSTAN dir
COPY make/local $CMDSTAN/make/local

# build cmdstan using 2 threads
RUN cd cmdstan-$CSVER \
  && make -j2 build examples/bernoulli/bernoulli

# install cmdstanpy with all features and all other stuff
RUN pip install --upgrade --no-cache-dir cmdstanpy[all] ipywidgets arviz numpy pandas seaborn pyarrow jupyter

# go back to the main user directory
USER user
WORKDIR /home/user

# entrypoint to terminal
ENTRYPOINT ["/bin/bash"]
