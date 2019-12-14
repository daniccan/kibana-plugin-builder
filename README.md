## Kibana Plugin Builder [![GitHub Actions](https://github.com/daniccan/kibana-plugin-builder/workflows/Deploy%20to%20DockerHub/badge.svg)](https://github.com/daniccan/kibana-plugin-builder) [![Docker Pulls](https://img.shields.io/docker/pulls/daniccan/kibana-plugin-builder.svg)](https://hub.docker.com/r/daniccan/kibana-plugin-builder)

A Docker image to build plugins for any given version of [Kibana](https://github.com/elastic/kibana).

### Requirements

- Docker
- A [Kibana Plugin](https://github.com/elastic/kibana/tree/master/packages/kbn-plugin-generator)

### Usage

```bash
docker run -it -e KIBANA_VERSION=$KIBANA_VERSION -e PLUGIN_VERSION=$PLUGIN_VERSION -v $KIBANA_PLUGIN_PATH:/kibana-extra/kibana-plugin --rm daniccan/kibana-plugin-builder
```

### Example

```bash
docker run -it -e KIBANA_VERSION=7.5.0 -e PLUGIN_VERSION=1.0.0 -v /home/username/my_plugin:/kibana-extra/kibana-plugin --rm daniccan/kibana-plugin-builder
```

### Issues

Find any bugs or need additional features? Please don't hesitate to [create an issue](https://github.com/daniccan/kibana-plugin-builder/issues/new).

### License

MIT Copyright (c) 2019 [daniccan](https://github.com/daniccan)
