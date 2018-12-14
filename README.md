# Postfix Milter Server

This project contains an example of hosting a Postfix server that forwards messages to a milter application, with the Postfix server hosted in Docker. This project is designed to run on CloudFoundry but it is not necessary.

## Build

Build the Docker image and push it to your Docker repository:

```
docker build -t <your docker repo>/postfix-server .

docker push <your docker repo>/postfix-server
```

## Run

The example of running the image assumes you already have a milter application running to receive the messages from Postfix (example will reference `<milter host>` and `<milter port>`).

To run the example on CloudFoundry:

```
cf push --docker-image <your docker repo>/postfix-server --no-route -i 0

cf set-env postfix-server JILTER_HOST <milter host>
cf set-env postfix-server JILTER_PORT <milter port>

cf scale postfix-server -i 1

cf map-route postfix-server <your tcp domain> --random-port
```

This will expose the SMTP port out on a random port selected by PCF. You can force a specific port using `--port` instead of `--random-port`.

You can validate connectivity like so:

```
nc <your tcp domain> <port from map-route>
```