#!/bin/bash

echo =============== Clone cquery ===============
git clone https://github.com/cquery-project/cquery macos/cquery && cd macos/cquery

echo =============== Prepare cquery for install ===============
./waf configure --bundled-llvm=6.0.0
./waf build --bundled-llvm=6.0.0

cd - # back to project root
