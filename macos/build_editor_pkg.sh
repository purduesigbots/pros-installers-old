#!/bin/bash

VERSION=$(defaults read PROS\ Editor.app/Contents/Info.plist CFBundleVersion)

echo =============== SETUP ENVIRONMENT ===============
unzip tmp/pros-editor-mac.zip
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
EOF

chmod +x macos/proseditor/scripts/*
echo =============== CREATE DISTRIBUTION ===============
cp -r PROS\ Editor.app macos/proseditorpkg/ROOT
pkgbuild \
  --root macos/proseditorpkg/ROOT/ \
  --scripts macos/proseditorpkg/scripts/ \
  --identifier edu.purdue.cs.pros.pros-editor
  --version $VERSION \
  --install-location /Applications \
  pros-editor.pkg
