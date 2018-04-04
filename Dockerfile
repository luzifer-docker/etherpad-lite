FROM node:9-stretch

LABEL maintainer Knut Ahlers <knut@ahlers.me>

ENV DEBIAN_FRONTEND noninteractive
ENV EP_VERSION 1.6.3

# Dependencies based on docs
RUN set -ex \
 && apt-get update \
 && apt-get --no-install-recommends -y install \
    build-essential \
    curl \
    git-core \
    gzip \
    libssl-dev \
    pkg-config \
    python \
    unzip \
 && mkdir /src \
 && curl -sSfLo /tmp/etherpad.zip https://github.com/ether/etherpad-lite/archive/${EP_VERSION}.zip \
 && unzip /tmp/etherpad.zip -d /src \
 && mv /src/etherpad-lite-* /src/etherpad \
 && sed -i '/installDeps.sh/d' /src/etherpad/bin/run.sh \
 && cd /src/etherpad && bin/installDeps.sh \
 && rm -rf /var/lib/apt/lists/* /tmp/etherpad.zip

COPY start.sh /start.sh

WORKDIR /src/etherpad

VOLUME /data

EXPOSE 9001

ENTRYPOINT ["/start.sh"]
CMD ["--"]
