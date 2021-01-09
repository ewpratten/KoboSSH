# KoboSSH

This repository contains the tools needed to compile [dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html) for the `arm-kobo-linux-gnueabihf` system (all recent [Kobo](https://www.kobo.com/) products). This binary is used for root shell access on Kobo devices which, in my case, is used to deploy and debug software on e-readers.

## Compiling locally

This project piggy-backs off the toolchain I use for [kolib](https://github.com/Ewpratten/kolib), so everything is done inside a docker container. Thus: you must have docker installed on your system to compile dropbear. With docker installed, simply run:

```sh
docker pull ewpratten/kolib_toolchain:crosstools
./compile.sh
```

The resulting ARM binary will be placed at `./dropbearmulti`

## Prebuilt binaries

I keep some prebuild binaries on the [releases page](https://github.com/Ewpratten/KoboSSH/releases).