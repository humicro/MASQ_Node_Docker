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

### Cross compilation to other generic archetectures
By utilizing [`cross`](https://github.com/rust-embedded/cross) and `docker-in-docker`, it is now pretty easy to cross compile `MASQ Node` to various generic architectures as listed [here](https://github.com/rust-embedded/cross#supported-targets).

```bash
# If you have not done so, build the Docker image "masq-compile-cross" first
$ docker-compose build masq-compile-cross

# Then edit TARGET_ARCHITECTURE in docker-compose.yml to your selected target
# The default option is set as mipsel-unknown-linux-gnu

# Cross compile MASQ Node
$ docker-compose run masq-compile-cross
```

Compiled `MASQ Node` binaries are located under sub directories under `builds/cross`.

## Testing/Hosting Tasks

Spin out a `Debian Slim` lightweight docker server to run the compiled `MASQ Node` binaries for testing and hosting.

Please make sure you have already performed the "masq-compile-linux" task to have `MASQ Node` binaries under `builds/linux-x86-64`.

```bash
# If you have not done so, build the Docker image "masq-run-node" first
$ docker-compose build masq-run-node

# (Optionally) Examine MASQ Node binaries
$ docker-compose run masq-run-node MASQNode --help
$ docker-compose run masq-run-node masq --help

# Run MASQNode!
# It automatically set External IP, DNS, Neighbors, Blockchain Service URL & DB Password for you! But you'd better understand what you are doing!
$ docker-compose run masq-run-node
```

*More to come ...*
