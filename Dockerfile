FROM alpine:3.14

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update; apk add openjdk17-jdk curl git

WORKDIR /server

RUN curl -L -o fabric-installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.11.0/fabric-installer-0.11.0.jar && \
    java -jar fabric-installer.jar server -downloadMinecraft -mcversion 1.19 \
    rm -rf fabric-installer.jar

COPY ./eula.txt /server/eula.txt
COPY ./server.properties /server/server.properties
COPY ./start.sh /server/start.sh

COPY ./files /server/files


ENV MINECRAFT_PORT 25565
ENV RCON_PORT 25575
ENV JAVA_MEMORY 3G
ENV RCON_ENABLED false
ENV WHITELIST_ENABLED false
ENV ALLOW_NETHER true
ENV GAME_MODE survival
ENV ENABLE_QUERY false
ENV PLAYER_IDLE_TIMEOUT 0
ENV DIFFICULTY easy
ENV SPAWN_MONSTERS true
ENV SPAWN_ANIMALS true
ENV SPAWN_NPCS true

ENV LEVEL_TYPE default
ENV PVP true
ENV BROADCAST_CONSOLE_TO_OPS true
ENV SPAWN_PROTECTION 0
ENV MAX_TICK_TIME 60000
ENV FORCE_GAMEMODE false

ENV OP_PERMISSION_LEVEL 4
ENV SNOOPER_ENABLED true
ENV HARDCORE false
ENV ENABLE_COMMAND_BLOCK true
ENV MAX_PLAYERS 150
ENV NETWORK_COMPRESSION_THRESHOLD 256

ENV MAX_WORLD_SIZE 29999984

ENV ALLOW_FLIGHT true
ENV LEVEL_NAME world
ENV VIEW_DISTANCE 10
ENV GENERATE_STRUCTURES true
ENV ONLINE_MODE false
ENV MAX_BUILD_HEIGHT 512

ENV PREVENT_PROXY_CONNECTION false


EXPOSE 25565/tcp
EXPOSE 25565/udp


ENTRYPOINT [ "./start.sh" ]
