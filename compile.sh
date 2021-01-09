#! /bin/bash

set -e

cd dropbear

echo "Generating build tools"
docker run -v $(pwd):/work ewpratten/kolib_toolchain:crosstools /bin/bash -c 'cd /work; autoconf; autoheader'


echo "Configuring dropbear to target arm-kobo-linux-gnueabihf"
docker run -v $(pwd):/work ewpratten/kolib_toolchain:crosstools /bin/bash -c 'export PATH="/root/x-tools/arm-kobo-linux-gnueabihf/bin:$PATH"; cd /work; ./configure --host=arm-kobo-linux-gnueabihf --disable-zlib --enable-static'

echo "Compiling dropbear"
docker run -v $(pwd):/work ewpratten/kolib_toolchain:crosstools /bin/bash -c 'export PATH="/root/x-tools/arm-kobo-linux-gnueabihf/bin:$PATH"; cd /work; make clean'
docker run -v $(pwd):/work ewpratten/kolib_toolchain:crosstools /bin/bash -c 'export PATH="/root/x-tools/arm-kobo-linux-gnueabihf/bin:$PATH"; cd /work; make PROGRAMS="dropbear dropbearkey" MULTI=1'

echo "Fetching binaries"
cp dropbearmulti ..