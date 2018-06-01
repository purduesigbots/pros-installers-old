#!/bin/bash

pkgbuild --root macos/prostoolchainpkg/ROOT \
	--scripts macos/prostoolchainpkg/scripts \
	--version 2017-q4-major \
	--identifier edu.purdue.cs.pros.pros-toolchain \
	--install-location /usr/local/lib \
	pros-toolchain.pkg
