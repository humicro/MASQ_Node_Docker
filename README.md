# MASQ Node Docker

Compile and run the latest version of MASQ Node within a Docker container.

## Build Docker

Here I name the docker image as `masq-node`, but you can use any name as you like.

The following command spins up a rust compiler machine, download the latest `MASQ Node` source code, compile all the binaries, and copy them over to a `Debian Slim` lightweight docker server.

```console
$ docker build -t masq-node .
```

## Examine MASQ Node binaries

```console
$ docker run -it masq-node MASQNode --help
$ docker run -it masq-node masq --help
```

## Run MASQ Node

*To be continued...*
