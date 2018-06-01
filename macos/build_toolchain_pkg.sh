#!/bin/bash

mkdir -p /tmp/artifacts

pkgbuild --root macos/toolchainpkg/ROOT \
	--scripts macos/toolchainpkg/scripts \
	--version 2017-q4-major \
	--identifier edu.purdue.cs.pros.pros-toolchain \
	--install-location /usr/local/lib \
	/tmp/artifacts/pros-toolchain.pkg
