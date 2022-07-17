#!/bin/sh -e

WORKDIR="/server"

function installAchievement {
    if [ ! -d "$WORKDIR/world/datapacks/${2}" ]; then
        echo "The installation of new achievements has begun."
        unzip $WORKDIR/files/datapacks/${1} -d $WORKDIR/files/datapacks/${2}
        mv $WORKDIR/files/datapacks/${2} $WORKDIR/world/datapacks
        echo "New achievements have been installed: ${2}"
    fi
}

function installPlugins {
    if [ ! -d "$WORKDIR/plugins" ]; then
        mkdir $WORKDIR/plugins
    fi

    function installPlugin {
        if [ ! -e "$WORKDIR/plugins/${2}" ]; then
            curl -L -o ./${2} ${1}
            mv ./${2} $WORKDIR/plugins
            echo "The plugin was successfully installed: ${2}"
        fi
    }

    installPlugin "https://github.com/plasmoapp/plasmo-voice/releases/download/1.0.10-spigot/plasmovoice-server-1.0.10.jar" "plasmovoice-server-1.0.10.jar"

    installPlugin "https://ci.dmulloy2.net/job/ProtocolLib/lastSuccessfulBuild/artifact/target/ProtocolLib.jar" "ProtocolLib.jar"

    installPlugin "https://github.com/KosmX/emotes/releases/download/2.1.3-SNAPSHOT-build.32/emotecraft-2.1.3-SNAPSHOT-build.31-bukkit.jar" "emotecraft-2.1.3.jar"

    installPlugin "https://github.com/jpenilla/MiniMOTD/releases/download/v2.0.8/minimotd-bukkit-2.0.8.jar" "mini-motd.jar"

    installPlugin "https://github.com/SkinsRestorer/SkinsRestorerX/releases/download/14.2.1/SkinsRestorer.jar" "SkinsRestorer.jar"

    # installPlugin "https://github.com/KiraPixel/PixeSlTab/releases/download/1.19/PixeSlTab-1.19-rel.6.jar" "PixeSl.jar"

    installPlugin "https://github.com/montlikadani/TabList/releases/download/v5.6.3/TabList-bukkit-5.6.3.jar" "TabList-bukkit-5.6.3.jar"

    mv ./files/plugins/emotecraft-2.1.3.jar $WORKDIR/plugins

    # ? Install configs for TabList
    mv $WORKDIR/files/TabList $WORKDIR/plugins

    # ? Install emotes for mod Emotecraft
    mv $WORKDIR/files/emotes $WORKDIR

    ls ./plugins -a
    ls -a
    ls ./emotes -a
}

if [ ! -d "$WORKDIR/world/datapacks" ]; then
    if [ ! -d "$WORKDIR/world" ]; then
        mkdir $WORKDIR/world
    fi

    mkdir $WORKDIR/world/datapacks
fi

function configs {
    # * MiniMOTD
    if [ -d "$WORKDIR/files/MiniMOTD" ]; then
        rm -rf $WORKDIR/plugins/MiniMOTD
    fi
    mv -f $WORKDIR/files/MiniMOTD $WORKDIR/plugins

    # * PlasmoVoice
    if [ -d "$WORKDIR/files/PlasmoVoice" ]; then
        rm -rf $WORKDIR/plugins/PlasmoVoice
    fi
    mv -f $WORKDIR/files/PlasmoVoice $WORKDIR/plugins
}

installAchievement "BlazeandCaves-Advancements-Pack-1.14.5.zip" "BlazeandCave-Advancements"

installAchievement "terralith-v2-3-2a.zip" "Terralith"

installPlugins

configs

if [ ! -d "$WORKDIR/config" ]; then
    mkdir $WORKDIR/config
fi

if [ ! -f "$WORKDIR/config/banned-ips.json" ]; then
    echo "[]" >> $WORKDIR/config/banned-ips.json
fi

if [ ! -f "$WORKDIR/config/banned-players.json" ]; then
    echo "[]" >> $WORKDIR/config/banned-players.json
fi

if [ ! -f "$WORKDIR/config/usercache.json" ]; then
    echo "[]" >> $WORKDIR/config/usercache.json
fi

if [ ! -f "$WORKDIR/config/whitelist.json" ]; then
    echo "[]" >> $WORKDIR/config/whitelist.json
fi

if [ ! -f "$WORKDIR/config/ops.json" ]; then
    echo "[]" >> $WORKDIR/config/ops.json
fi

ln -s $WORKDIR/config/banned-ips.json $WORKDIR/banned-ips.json
ln -s $WORKDIR/config/banned-players.json $WORKDIR/banned-players.json
ln -s $WORKDIR/config/usercache.json $WORKDIR/usercache.json
ln -s $WORKDIR/config/whitelist.json $WORKDIR/whitelist.json
ln -s $WORKDIR/config/ops.json $WORKDIR/ops.json

eval "echo \"$(cat ./server.properties)\"" > $WORKDIR/server.properties

java -Xmx${JAVA_MEMORY} -Xms${JAVA_MEMORY} -Dfml.queryResult=confirm -jar paper.jar --nogui