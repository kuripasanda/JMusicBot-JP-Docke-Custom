FROM alpine:latest AS builder

ENV JMUSICBOT_VERSION=0.9.9

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot-Custom.jar https://github.com/kuripasanda/JMusicBot-JP-Custom/releases/download/${JMUSICBOT_VERSION}/JMusicBot-Customized-${JMUSICBOT_VERSION}-All.jar


FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /jmusicbot
COPY --from=builder /build .
RUN apk update &&\
    apk add --no-cache ffmpeg python3

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot-Custom.jar" ]
