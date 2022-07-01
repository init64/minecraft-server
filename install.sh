#!/bin/bash

function installAchievements {
    echo "The installation of new achievements has begun."
    curl -O https://mediafiles.forgecdn.net/files/3823/719/BlazeandCave\'s+Advancements+Pack+1.14.1.zip
    mv ./BlazeandCave\'s+Advancements+Pack+1.14.1.zip ./world/datapacks
    echo "New achievements have been installed :D"
}

installAchievements