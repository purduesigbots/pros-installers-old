#!/bin/bash

productbuild --distribution macos/prospkg/distribution.xml --resources macos/prospkg/resources --scripts macos/prospkg/scripts --package-path /tmp/artifacts --sign "$APPLE_CCN" pros-macOS.pkg
