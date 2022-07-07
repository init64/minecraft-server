#!/bin/sh

function installAchievements {
    echo "The installation of new achievements has begun."
    mkdir ./world
    mkdir ./world/datapacks
    curl -O https://mediafiles.forgecdn.net/files/3823/719/BlazeandCave\'s+Advancements+Pack+1.14.1.zip
    mv ./BlazeandCave\'s+Advancements+Pack+1.14.1.zip ./world/datapacks
    unzip ./world/datapacks/BlazeandCave\'s+Advancements+Pack\+1.14.1.zip -d ./world/datapacks/BlazeandCave-Advancements
    echo "New achievements have been installed :D"
}

installAchievements
