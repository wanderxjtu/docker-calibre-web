FROM python:3.12-bookworm

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="wanderhuang@gmail.com"

RUN \
  echo "**** install build packages ****" && \
  apt-get update && \
  echo "**** install runtime packages ****" && \
  apt-get install -y --no-install-recommends \
    imagemagick \
    ghostscript \
    libldap-2.5-0 \
    libmagic1 \
    libsasl2-2 \
    libxi6 \
    libxslt1.1 \
    sqlite3 \
    xdg-utils \
    curl && \
  echo "**** install calibre-web ****" && \
  pip install -U --no-cache-dir \
    pip \
    wheel && \
  pip install calibreweb && \
  echo "**** cleanup ****" && \
  apt-get -y autoremove && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /root/.cache

# add local files
#COPY root/ /

# add unrar
#COPY --from=unrar /usr/bin/unrar-ubuntu /usr/bin/unrar

# ports and volumes
EXPOSE 8083

ENTRYPOINT ["cps"]