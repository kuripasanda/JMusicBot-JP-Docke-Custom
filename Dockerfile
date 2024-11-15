FROM alpine:latest AS builder

ENV JMUSICBOT_VERSION=0.9.11

WORKDIR /build
RUN apk update &&\
    apk add --no-cache curl

RUN curl -SLo JMusicBot-Custom.jar https://github.com/kuripasanda/JMusicBot-JP-Custom/releases/download/${JMUSICBOT_VERSION}/JMusicBot-Customized-${JMUSICBOT_VERSION}-All.jar


FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /jmusicbot
COPY --from=builder /build .
RUN apk update &&\
    apk add --no-cache ffmpeg python3 py3-pip python3-dev gcc musl-dev &&\
    python3 -m pip install -U --pre --no-cache-dir yt-dlp &&\
    apk del py3-pip python3-dev gcc musl-dev

ENTRYPOINT [ "java", "-Dnogui=true", "-jar", "JMusicBot-Custom.jar" ]
