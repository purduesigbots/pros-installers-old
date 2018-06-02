#!/bin/bash

productbuild --resources macos/prospkg/resources \
  --scripts macos/prospkg/scripts \
  --distribution macos/prospkg/distribution.xml \
  --package-path /tmp/artifacts \
  --sign $APPLE_CCN \
  pros-macOS.pkg
