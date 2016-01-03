# luzifer / etherpad-lite

This repository holds the sources for a Docker build of etherpad-lite. You can use it as-is or build your own image with your preferred set of plugins / modules installed.

## Simple Usage

- Have a directory containing your `settings.json` file (this example uses `/data/etherpad-lite`)
- Start the container using this command

```
docker run -p 9001:9001 -v /data/etherpad-lite:/data quay.io/luzifer/etherpad-lite
```

- Access your etherpad at localhost on port 9001

## Building your own container

- Search for etherpad modules in NPM registry: `npm search ep_`
- Create your `Dockerfile`:

```Dockerfile
FROM quay.io/luzifer/etherpad-lite

WORKDIR /src/etherpad/src
RUN npm install ep_author_hover ep_adminpads
```

- Build your container: `docker build -t my_etherpad-lite .`
- Run it:

```
docker run -p 9001:9001 -v /data/etherpad-lite:/data my_etherpad-lite
```
