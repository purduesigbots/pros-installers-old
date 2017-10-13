#!/bin/sh

mkdir -p ./debian/pros-64/usr/lib/pros
mkdir -p ./debian/pros-32/usr/lib/pros
unzip pros_cli-*-lin-64bit.zip -d ./debian/pros-64/usr/lib/pros/
unzip pros_cli-*-lin-32bit.zip -d ./debian/pros-32/usr/lib/pros/

cat > ./debian/pros-32/DEBIAN/control << EOF
Package: pros-core
Maintainer: Purdue ACM SIGBots
Priority: Optional
Depends: gcc-arm-none-eabi
Description: PROS core components, including the CLI and Arm Toolchain
Architecture: i386
Version: `cat ./win_version`

EOF

cat > ./debian/pros-64/DEBIAN/control << EOF
Package: pros-core
Maintainer: Purdue ACM SIGBots
Priority: Optional
Depends: gcc-arm-none-eabi
Description: PROS core components, including the CLI and Arm Toolchain
Architecture: amd64
Version: `cat ./win_version`

EOF

mkdir -p ./debian/pros-32/usr/bin
mkdir -p ./debian/pros-64/usr/bin
ln -s /usr/lib/pros/pros ./debian/pros-32/usr/bin/pros
ln -s /usr/lib/pros/pros ./debian/pros-64/usr/bin/pros

dpkg-deb -b debian/pros-64 pros-core-`cat ./version`-amd64.deb
dpkg-deb -b debian/pros-32 pros-core-`cat ./version`-i386.deb
