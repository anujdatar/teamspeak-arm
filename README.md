# teamspeak-arm
TeamSpeak3 server running in a docker container on an ARM device. Uses
[anujdatar/box860](https://hub.docker.com/repository/docker/anujdatar/box86) as
the base image.

## Running the server
```bash
$ docker run -p 9987:9987/udp -p 10011:10011 -p 30033:30033 anujdatar/teamspeak-arm
```

