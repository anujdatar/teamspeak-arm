FROM debian:buster-slim as downloader
ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl jq bzip2

# Downlad and extract latest ts3 server binary
RUN wget $(curl -Ls 'https://www.teamspeak.com/versions/server.json' | jq -r '.linux.x86.mirrors | values[]')
RUN tar xvf teamspeak3-server_linux_x86-*
WORKDIR teamspeak3-server_linux_x86
RUN touch .ts3server_license_accepted

# ****************************************************************
# run teamspeak on the base box86 image
FROM anujdatar/box86:latest

COPY --from=downloader /teamspeak3-server_linux_x86 /ts3-server
WORKDIR /ts3-server

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

CMD ["/box86/build/box86", "ts3server"]

