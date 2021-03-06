# MASQ Node Docker Series

A collection of Docker containers for `MASQ Node` compilation, testing and hosting.

**Note**: These containers have been tested on 64-bit Linux. You are welcome to report any issues on MacOS & Windows.

## Build Docker Images

In order to perform tasks in next steps, you need to build corresponding Docker images first.

You can build individual images for your specific tasks:

```bash
# "masq-compile-linux" as an example
$ docker-compose build masq-compile-linux
```

Or, you can build these images all at once (**NOT RECOMMENDED!**):

```bash
$ docker-compose build
```

## Compilation Tasks

### Linux x86-64

This task compiles `MASQ Node` to the most common architecture of Linux: x86-64.

```bash
# If you have not done so, build the Docker image "masq-compile-linux" first
$ docker-compose build masq-compile-linux

# Compile MASQ Node to Linux x86-64
$ docker-compose run masq-compile-linux
```

Compiled `MASQ Node` `x86-64` binaries are located under directory `builds/linux-x86-64`.

### Raspberry Pi

This task cross compiles `MASQ Node` to Raspberry Pi.

```bash
# If you have not done so, build the Docker image "masq-compile-pi" first
$ docker-compose build masq-compile-pi

# Compile MASQ Node to Raspberry Pi
$ docker-compose run masq-compile-pi
```

Compiled `MASQ Node` `arm6` binaries are located under directory `builds/rpi-arm6`.

This build targets `arm6` architecture (Raspberry Pi 1 & Zero), but should also be compatible with newer versions (Raspberry Pi 2, 3 & 4). You are recommended to run these binaries using the latest official operating system [`Raspberry Pi OS 32-bit`](https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit).

## Testing/Hosting Tasks

Spin out a `Debian Slim` lightweight docker server to run the compiled `MASQ Node` binaries for testing and hosting.

Please make sure you have already performed the "masq-compile-linux" task to have `MASQ Node` binaries under `builds/linux-x86-64`.

```bash
# If you have not done so, build the Docker image "masq-run-node" first
$ docker-compose build masq-run-node

# Log into the docker server
$ docker-compose run masq-run-node

# Examine MASQ Node binaries (under docker server)
$ MASQNode --help
$ masq --help
```

*More to come ...*
