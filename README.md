## Kibana Plugin Builder [![GitHub Actions](https://github.com/daniccan/kibana-plugin-builder/workflows/Deploy%20to%20DockerHub/badge.svg)](https://github.com/daniccan/kibana-plugin-builder) [![Docker Pulls](https://img.shields.io/docker/pulls/daniccan/kibana-plugin-builder.svg)](https://hub.docker.com/r/daniccan/kibana-plugin-builder)

A Docker image to build plugins for any given version of [Kibana](https://github.com/elastic/kibana).

### Requirements

- Docker
- A [Kibana Plugin](https://github.com/elastic/kibana/tree/master/packages/kbn-plugin-generator)

### Usage

```bash
docker run -it -e KIBANA_VERSION=<KIBANA_VERSION> -e PLUGIN_VERSION=<PLUGIN_VERSION> -e LOCAL_USER_ID=`id -u $USER` -v <KIBANA_PLUGIN_PATH>:/home/ubuntu/kibana-extra/kibana-plugin --rm daniccan/kibana-plugin-builder
```

### Example

```bash
docker run -it -e KIBANA_VERSION=7.6.0 -e PLUGIN_VERSION=1.0.0 -e LOCAL_USER_ID=`id -u $USER` -v /home/username/my_plugin:/home/ubuntu/kibana-extra/kibana-plugin --rm daniccan/kibana-plugin-builder
```

### Supported Kibana Versions

| Major Version        | Minor Version(s)                                 |
|----------------------|--------------------------------------------------|
| 6.x                  | 6.5.x, 6.6.x, 6.7.x, 6.8.x                       |
| 7.x                  | 7.0.x, 7.1.x, 7.2.x, 7.3.x, 7.4.x, 7.5.x         |

### Issues

Find any bugs or need additional features? Please don't hesitate to [create an issue](https://github.com/daniccan/kibana-plugin-builder/issues/new).

### License

MIT Copyright (c) 2019 [daniccan](https://github.com/daniccan)
