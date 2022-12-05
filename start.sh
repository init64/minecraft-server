#!/bin/sh -e

function installMods {
    if [ ! -d "/server/mods" ]; then
        mkdir /server/mods
    fi

    function installModRemotly {
        if [ ! -e "/server/mods/${2}" ]; then
            curl -l -o ./${2} ${1}
            mv ./${2} /server/mods
            echo "the mod was successfully installed: ${2}"
        fi
    }
}

installMods

if [ ! -d "/server/config" ]; then
    mkdir /server/config
fi

if [ ! -f "/server/config/banned-ips.json" ]; then
    echo "[]" >> /server/config/banned-ips.json
fi

if [ ! -f "/server/config/banned-players.json" ]; then
    echo "[]" >> /server/config/banned-players.json
fi

if [ ! -f "/server/config/usercache.json" ]; then
    echo "[]" >> /server/config/usercache.json
fi

if [ ! -f "/server/config/whitelist.json" ]; then
    echo "[]" >> /server/config/whitelist.json
fi

if [ ! -f "/server/config/ops.json" ]; then
    echo "[]" >> /server/config/ops.json
fi

ln -s /server/config/banned-ips.json /server/banned-ips.json
ln -s /server/config/banned-players.json /server/banned-players.json
ln -s /server/config/usercache.json /server/usercache.json
ln -s /server/config/whitelist.json /server/whitelist.json
ln -s /server/config/ops.json /server/ops.json

eval "echo \"$(cat ./server.properties)\"" > /server/server.properties

java -Xmx${JAVA_MEMORY} -Xms${JAVA_MEMORY} -Dfml.queryResult=confirm -jar fabric-server-launch.jar nogui
