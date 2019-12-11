# Kibana Plugin Builder

A Docker image to build plugins for any given version of [Kibana](https://github.com/elastic/kibana).

## Requirements

- Docker
- A [Kibana Plugin](https://github.com/elastic/kibana/tree/master/packages/kbn-plugin-generator)

## Usage

```bash
docker run -it -e KIBANA_VERSION=$KIBANA_VERSION -e PLUGIN_VERSION=$PLUGIN_VERSION -v $KIBANA_PLUGIN_PATH:/kibana-extra/kibana-plugin --rm kibana-plugin-builder
```

*Note:* $KIBANA_VERSION should match with the branch name in [Kibana GitHub Branches](https://github.com/elastic/kibana/branches/active).

### Example

```bash
docker run -it -e KIBANA_VERSION=6.8 -e PLUGIN_VERSION=1.0.0 -v /home/username/my_plugin:/kibana-extra/kibana-plugin --rm kibana-plugin-builder
```

### Issues

Find any bugs or need additional features? Please don't hesitate to [create an issue](https://github.com/daniccan/kibana-plugin-builder/issues/new).

### License

MIT Copyright (c) 2019 [daniccan](https://github.com/daniccan)
