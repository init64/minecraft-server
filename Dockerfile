FROM alpine:3.14

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update; apk add openjdk17-jdk curl

COPY ./server /server

WORKDIR /server

RUN ./install.sh

EXPOSE 25565/tcp
EXPOSE 25565/udp

ENTRYPOINT ["./start.sh"]