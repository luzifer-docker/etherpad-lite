FROM node:0.12

MAINTAINER Knut Ahlers <knut@ahlers.me>

ENV DEBIAN_FRONTEND noninteractive
ENV EP_VERSION 1.5.7
#ENV EP_MODULES ep_headings ep_monospace_default ep_print ep_adminpads

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
ONBUILD RUN npm install ${EP_MODULES}

VOLUME /data

EXPOSE 9001

ENTRYPOINT ["/start.sh"]
CMD ["--"]
