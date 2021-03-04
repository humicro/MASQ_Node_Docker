# MASQ Node Docker Series

A collection of Docker containers for `MASQ Node` compilation, testing and hosting.

## Build Docker Images

In order to perform tasks in next steps, you need to build corresponding Docker images first.

You can build individual images for your specific tasks:

```console
# "masq-compile-linux" as an example
$ docker-compose build masq-compile-linux
```

Or, you can build these images all at once:

```console
$ docker-compose build
```

## Compilation Tasks

### Linux x86-64

This task compiles `MASQ Node` to the most common architecture of Linux: x86-64.

```console
# If you have not done so, build the Docker image "masq-compile-linux" first
$ docker-compose build masq-compile-linux

# Compile MASQ Node to Linux x86-64
$ docker-compose run masq-compile-linux
```

Compiled `MASQ Node` binaries are located under directory `builds/linux-x86-64`.

## Testing/Hosting Tasks

Spin out a `Debian Slim` lightweight docker server to run the compiled `MASQ Node` binaries for testing and hosting.

Please make sure you have already performed the "masq-compile-linux" task to have `MASQ Node` binaries under `builds/linux-x86-64`.

```console
# If you have not done so, build the Docker image "masq-run-node" first
$ docker-compose build masq-run-node

# Log into the docker server
$ docker-compose run masq-run-node

# Examine MASQ Node binaries (under docker server)
$ MASQNode --help
$ masq --help
```

*More to come ...*
