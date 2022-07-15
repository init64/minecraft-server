#!/bin/bash

function build {
    docker build -t mc-server .
}

function run {
    docker run --rm -p 25565:25565/tcp -p 25565:25565/udp -v "$(pwd)"/world:/server/world -v "$(pwd)"/mods:/server/mods -v "$(pwd)"/config:/server/config mc-server
}

if [ "$1" == "build" ]
then
    build
elif [ "$1" == "run" ]
then
    run
elif [ "$1" == "auto" ]
then
    build
    run
else
    echo "There is no such command :("
fi