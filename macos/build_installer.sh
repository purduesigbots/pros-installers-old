#!/bin/bash

productbuild --resource macos/prospkg/resources \
  --package-path /tmp/artifacts/proscli.pkg \
  --package-path /tmp/artifacts/pros-toolchain.pkg \
  --package-path /tmp/artifacts/pros-editor.pkg \
  --distribution macos/prospkg/distribution.xml \
  pros-macOS.unsigned.pkg

productsign --keychain $KEYCHAIN --sign $APPLE_CCN pros-macOS.unsigned.pkg pros-macOS.pkg
