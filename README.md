# Postfix Milter Server

This project contains an example of hosting a Postfix server that forwards messages to a milter application, with the Postfix server hosted in Docker. This project is designed to run on CloudFoundry but it is not necessary.

## Build

Build the Docker image and push it to your Docker repository:

```
docker build -t <your docker repo>/postfix-server .

docker push <your docker repo>/postfix-server
```

## Run

This example of running the server uses CloudFoundry, and uses some placeholder values to make things clearer:

- Milter app running on 10.0.0.1 port 8080
- CF TCP routing already set up using domain tcp.pcf.example.com

To run the example:

```
cf push --docker-image <your docker repo>/postfix-server --no-route -i 0

cf set-env postfix-server JILTER_HOST 10.0.0.1
cf set-env postfix-server JILTER_PORT 8080

cf scale postfix-server -i 1

cf map-route postfix-server tcp.pcf.example.com --port 1116
```

This will expose the SMTP port out via TCP routing on port 1116.

You can validate connectivity like so:

```
nc tcp.pcf.example.com 1116
```