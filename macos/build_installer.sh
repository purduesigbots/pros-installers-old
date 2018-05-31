#!/bin/bash

CLI_BUILD_NUM=$(cat ./CLI_BUILD_NUM)
EDITOR_BUILD_NUM=$(cat ./EDITOR_BUILD_NUM)
URL_BASE=https://circleci.com/api/v1.1/project/github/purduesigbots

CLI_ARTIFACT_URL_BASE=$(curl $URL_BASE/pros-cli/$CLI_BUILD_NUM/artifacts?circle-token=$CLI_TOKEN | jq --raw-output --exit-status '.[0].url')
CLI_ARTIFACT_DOWNLOAD_URL=$CLI_ARTIFACT_URL?circle-token=$CLI_TOKEN
curl -o pros-cli.pkg $CLI_ARTIFACT_DOWNLOAD_URL

EDITOR_ARTIFACT_URL_BASE=$(curl $URL_BASE/pros-editor/$EDITOR_BUILD_NUM/artifacts?circle-token=$EDITOR_TOKEN | jq --raw-output --exit-status '.[0].url')
EDITOR_ARTIFACT_DOWNLOAD_URL=$CLI_ARTIFACT_URL?circle-token=$CLI_TOKEN
curl -o pros-editor-mac.zip $EDITOR_ARTIFACT_DOWNLOAD_URL
unzip pros-editor-mac.zip

# todo: productbuild
