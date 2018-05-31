#!/bin/bash
BASE_URL=https://circleci.com/api/v1.1/project/github/purduesigbots/atom
echo =============== TRIGGER EDITOR BUILD ===============
# will run build and return build number, which we need to construct the endpoint for blocking
BUILD_NUMBER=$(curl -X POST $BASE_URL?circle-token=$CLI_TOKEN | jq --raw-output --exit-status '.build_number)
# save build number to a file for access in another script later
echo $BUILD_NUMBER > EDITOR_BUILD_NUM

echo =============== WAITING FOR BUILD TO COMPLETE ===============
./macos/wait_for_build.sh $CLI_TOKEN $BASE_URL/$BUILD_NUMBER 3600
