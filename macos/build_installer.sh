#!/bin/bash

productbuild --distribution macos/prospkg/distribution.xml --resources macos/prospkg/resources --scripts macos/prospkg/scripts --package-path /tmp/artifacts pros-macOS.unsigned.pkg
productsign --sign "$APPLE_CCN" pros-macOS.unsigned.pkg pros-macOS.pkg
