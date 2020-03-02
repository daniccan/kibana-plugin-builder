#!/bin/bash

INFO_COLOR="\e[34m"
SUCCESS_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
LOG_END="\e[0m"
NEW_LINE=""

echo -e "$INFO_COLOR Kibana Plugin Build Started. $LOG_END"

echo $NEW_LINE

if [ -z "$KIBANA_VERSION" ]
    then
        echo -e "$ERROR_COLOR KIBANA_VERSION environment variable is required. $LOG_END"
        exit 1
fi

if [ -z "$PLUGIN_VERSION" ]
    then
        PLUGIN_VERSION="1.0.0-$KIBANA_VERSION"
fi

KIBANA_BRANCH=$KIBANA_VERSION
# Check if KIBANA_VERSION is MAJOR.MINOR version or MAJOR.MINOR.PATCH version
number_of_dots=`awk -F"." '{print NF-1}' <<< $KIBANA_VERSION`
if [ "$number_of_dots" == 2 ]
    then
        readarray -d . -t strarr <<< $KIBANA_VERSION
        KIBANA_BRANCH="${strarr[0]}.${strarr[1]}"
fi

echo -e "$INFO_COLOR Cloning Kibana Version: $KIBANA_VERSION $LOG_END"

git clone --branch v$KIBANA_VERSION --depth 1 https://github.com/elastic/kibana /home/ubuntu/kibana

echo $NEW_LINE

NODE_VERSION=`cat /home/ubuntu/kibana/.node-version`

if [ "$NODE_VERSION" == "404: Not Found" ]
    then
        echo -e "$ERROR_COLOR Node Version not found for Kibana. $LOG_END"
        exit 1
fi

echo -e "$INFO_COLOR Install NVM $LOG_END"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo -e "$SUCCESS_COLOR NVM Installed Successfully. Version:"  `nvm --version` $LOG_END

echo $NEW_LINE

echo -e "$INFO_COLOR Install Node $LOG_END"

nvm install $NODE_VERSION

echo -e "$SUCCESS_COLOR Node Installed Successfully. Version:"  `node --version` $LOG_END

echo $NEW_LINE

echo -e "$INFO_COLOR Install Node Dependencies $LOG_END"

npm install -g yarn

echo -e "$SUCCESS_COLOR Node Dependencies Installed Successfully. $LOG_END"

echo $NEW_LINE

echo -e "$INFO_COLOR Bootstrap Kibana $LOG_END"

cd /home/ubuntu/kibana && yarn kbn bootstrap && cd ../kibana-extra/kibana-plugin

echo $NEW_LINE

echo -e "$INFO_COLOR Build Kibana Plugin $LOG_END"

package_json=$(cat package.json)
kibana_version_in_package_json=$(jq ".kibana.version"<<<$package_json)

if [ -f ".kibana-plugin-helpers.json" ] && [ "$kibana_version_in_package_json" == "\"kibana\"" ]
    then    # Set Kibana Version in .kibana-plugin-helpers.json
        echo -e "$INFO_COLOR Update .kibana-plugin-helpers.json $LOG_END"
        kibana_plugin_helpers_json=$(cat .kibana-plugin-helpers.json)
        kibana_plugin_helpers_json=$(jq ".version = \"$PLUGIN_VERSION\""<<<$kibana_plugin_helpers_json)
        kibana_plugin_helpers_json=$(jq ".pkg.kibana.version = \"$KIBANA_VERSION\""<<<$kibana_plugin_helpers_json)
        jq "."<<<$kibana_plugin_helpers_json > .kibana-plugin-helpers.json

else    # Set Kibana & Plugin Version in package.json
    echo -e "$INFO_COLOR Update package.json $LOG_END"
    package_json=$(jq ".version = \"$PLUGIN_VERSION\""<<<$package_json)
    package_json=$(jq ".kibana.version = \"$KIBANA_VERSION\""<<<$package_json)
    jq "."<<<$package_json > package.json
fi

rm -f yarn.lock && yarn build

echo $NEW_LINE

echo -e "$SUCCESS_COLOR Kibana Plugin Build Completed. $LOG_END"
