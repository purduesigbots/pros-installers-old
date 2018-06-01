#!/bin/bash

# todo: productbuild
productbuild --resource macos/prospkg/resources \
  --package-path /tmp/proscli.pkg \
  --package-path pros-toolchain.pkg #todo \
  --package-path proseditor.pkg \
  --distribution macos/prospkg/distribution.xml \
  pros.pkg
