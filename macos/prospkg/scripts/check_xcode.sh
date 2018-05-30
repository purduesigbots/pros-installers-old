#!/bin/sh

echo "Verifying xcode tools are on path..."
xcode-select --print-path
exit $?
