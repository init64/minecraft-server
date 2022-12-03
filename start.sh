#!/bin/sh -e

function installAchievements {
    if [ ! -d "/server/world/datapacks/BlazeandCave-Advancements" ]; then
        echo "The installation of new achievements has begun."
        unzip /server/files/datapacks/BlazeandCaves-Advancements-Pack-1.14.5.zip -d /server/files/datapacks/BlazeandCave-Advancements
        mv /server/files/datapacks/BlazeandCave-Advancements /server/world/datapacks
        echo "New achievements have been installed :D"
    fi
}

function installMods {
    if [ ! -d "/server/mods" ]; then
        mkdir /server/mods
    fi

    function installMod {
        if [ ! -e "/server/mods/${2}" ]; then
            curl -L -o ./${2} ${1}
            mv ./${2} /server/mods
            echo "The mod was successfully installed: ${2}"
        fi
    }

    # * SkinRestorer
    installMod "https://mediafiles.forgecdn.net/files/3826/618/skin-restorer-1.1.0.jar" "skin-restorer-1.1.0.jar"
}

function configs {
    # * MiniMOTD
    if [ -d "/server/files/MiniMOTD" ]; then
        rm -rf /server/config/MiniMOTD
    fi
    mv -f /server/files/MiniMOTD /server/config

    # * PlasmoVoice
    if [ -d "/server/files/PlasmoVoice" ]; then
        rm -rf /server/config/PlasmoVoice
    fi
    mv -f /server/files/PlasmoVoice /server/config
}

if [ ! -d "/server/world/datapacks" ]; then
    if [ ! -d "/server/world" ]; then
        mkdir /server/world
    fi

    mkdir /server/world/datapacks
fi

installAchievements

installMods

configs

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
