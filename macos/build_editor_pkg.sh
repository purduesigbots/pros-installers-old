#!/bin/bash

echo =============== SETUP ENVIRONMENT ===============
unzip atom/out/pros-editor-mac.zip
cp -r macos/cquery PROS\ Editor.app/Contents/MacOS/
mkdir -p macos/proseditorpkg/{ROOT,scripts}

echo =============== CREATE SCRIPTS ===============
cat << EOF > macos/proseditorpkg/scripts/preinstall
#!/bin/sh
if [ ! -d /usr/local/bin ]; then
  mkdir -p /usr/local/bin
fi
if [ -e /Applications/PROS\ Editor.app ]; then
  rm -rf /Applications/PROS\ Editor.app
fi
EOF

cat << EOF > macos/proseditorpkg/scripts/postinstall
#!/bin/sh
cd /Applications/PROS\ Editor.app/Contents/MacOS/cquery
./waf install --bundled-clang=6.0.0
cd -
EOF

chmod +x macos/proseditorpkg/scripts/{preinstall,postinstall}
echo =============== CREATE DISTRIBUTION ===============
cp -r PROS\ Editor.app macos/proseditorpkg/ROOT
mkdir -p /tmp/artifacts
pkgbuild \
  --root macos/proseditorpkg/ROOT/ \
  --scripts macos/proseditorpkg/scripts/ \
  --identifier edu.purdue.cs.pros.pros-editor \
  --version $(cat editor_version) \
  --install-location /Applications \
  /tmp/artifacts/pros-editor.pkg
