#!/bin/bash

echo =============== TRIGGER CLI BUILD ===============
# will run build and return build number, which we need to construct the endpoint for blocking
BUILD_NUMBER=$(curl -X POST https://circleci.com/api/v1.1/project/github/purduesigbots/pros-cli?circle-token=$CLI_TOKEN | jq --raw-output --exit-status '.build_number)

echo =============== WAITING FOR BUILD TO COMPLETE ===============
./macos/wait_for_build.sh $CLI_TOKEN https://circleci.com/api/v1.1/project/github/purduesigbots/pros-cli/$BUILD_NUMBER 3600
