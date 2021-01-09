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

## Kobo-side setup

Dropbear needs somewhere to go on the system. I chose `/mnt/onboard/opt/dropbear`. With the binary copied over, the following commands will set up ssh keys for the device:

```sh
cd /mnt/onboard/opt/dropbear
./dropbearmulti dropbearkey -t dss -f dss_key
./dropbearmulti dropbearkey -t rsa -f rsa_key
./dropbearmulti dropbearkey -t ecdsa -f ecdsa_key
```

The following command can be used to test dropbear:

```sh
/mnt/onboard/opt/dropbear/dropbearmulti dropbear -F -E -r /mnt/onboard/opt/dropbear/dss_key -r /mnt/onboard/opt/dropbear/rsa_key -r /mnt/onboard/opt/dropbear/ecdsa_key -B
```

To make dropbear start on boot, add the following line to `/opt/inetd.conf`:

```text
22 stream tcp nowait root /mnt/onboard/opt/dropbear/dropbearmulti dropbear -i -r /mnt/onboard/opt/dropbear/dss_key -r /mnt/onboard/opt/dropbear/rsa_key -r /mnt/onboard/opt/dropbear/ecdsa_key -B
```

Rebooting should start up an SSH server on the device.