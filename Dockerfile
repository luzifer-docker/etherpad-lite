FROM node

MAINTAINER Knut Ahlers <knut@ahlers.me>

ENV DEBIAN_FRONTEND noninteractive
ENV EP_VERSION develop

# Prepare etherpad
RUN mkdir /src
WORKDIR /src

ADD https://github.com/ether/etherpad-lite/archive/${EP_VERSION}.zip /src/etherpad.zip
ADD start.sh /start.sh

# Dependencies based on docs
RUN apt-get update \
 && apt-get -y install gzip git-core curl python libssl-dev pkg-config build-essential unzip

RUN unzip etherpad \
 && rm -f etherpad.zip \
 && mv etherpad-lite-* etherpad \
 && sed '/installDeps.sh/d' etherpad/bin/run.sh -i

WORKDIR /src/etherpad

# Install dependencies & modules
RUN bin/installDeps.sh

VOLUME /data

EXPOSE 9001

ENTRYPOINT ["/start.sh"]
CMD ["--"]
