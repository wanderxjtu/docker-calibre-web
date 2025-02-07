FROM docker.io/ubuntu:24.04

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="wanderhuang@gmail.com"

RUN \
  echo "**** install build packages ****" && \
  apt-get update && \
  echo "**** install runtime packages ****" && \
  apt-get install -y --no-install-recommends \
    python3.12 \
    python3-pip \
    python3-wand \
    python3-chardet \
    python3-tornado \
    python3-apscheduler \
    python3-babel \
    python3-flask \
    python3-flask-principal \
    python3-flask-limiter \
    python3-flask-babel \
    python3-flask-httpauth \
    python3-flask-dance \
    python3-netifaces \
    python3-pycountry \
    python3-pythonmagick \
    python3-jinja2 \
    python3-regex \
    python3-markupsafe \
    python3-pytzdata \
    python3-requests \
    python3-pypdf \
    python3-sqlalchemy \
    python3-cryptography \
    python3-lxml \
    python3-unidecode \
    python3-urllib3 \
    python3-bleach \
    libldap2 \
    libmagic1t64 \
    libsasl2-2 \
    libxi6 \
    libxslt1.1 \
    sqlite3 && \
  echo "**** cleanup ****" && \
  apt-get -y autoremove && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /root/.cache
WORKDIR /app
RUN \
  echo "**** install calibre-web ****" && \
  pip install --break-system-packages --no-cache-dir \
    calibreweb \
    calibreweb[oauth] \
    && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /root/.cache
RUN \
  echo "**** fix mobi mimetypes for <=0.6.24 ****" && \
  sed -i "/.mobi/s|application/octet-stream|application/x-mobipocket-ebook|" /usr/local/lib/python3.12/dist-packages/calibreweb/cps/__init__.py

# add local files
#COPY root/ /

# add unrar
#COPY --from=unrar /usr/bin/unrar-ubuntu /usr/bin/unrar

# ports and volumes
EXPOSE 8083

ENTRYPOINT ["cps"]
