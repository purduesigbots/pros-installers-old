#!/bin/bash

ls /tmp/artifacts
ls .
ls macos/prospkg
pwd

cp /tmp/artifacts/{pros-editor.pkg,pros-cli.pkg,pros-toolchain.pkg} macos/prospkg
productbuild --resources macos/prospkg/resources --scripts macos/prospkg/scripts --distribution macos/prospkg/distribution.xml --package-path macos/prospkg --sign $APPLE_CCN pros-macOS.pkg
