#!/bin/bash

echo =============== Clone cquery ===============
git clone --depth=1 https://github.com/cquery-project/cquery macos/cquery && cd macos/cquery
git submodule update --init

echo =============== Prepare cquery for install ===============
./waf configure --bundled-clang=6.0.0
./waf build --bundled-clang=6.0.0

cd - # back to project root
