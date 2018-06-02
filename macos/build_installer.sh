#!/bin/bash

ls /tmp/artifacts
ls .
ls macos/prospkg
pwd

# cp /tmp/artifacts/{pros-editor.pkg,pros-cli.pkg,pros-toolchain.pkg} macos/prospkg
productbuild --distribution macos/prospkg/distribution.xml --resources macos/prospkg/resources --scripts macos/prospkg/scripts --package-path /tmp/artifacts --sign $APPLE_CCN pros-macOS.pkg
