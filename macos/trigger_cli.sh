#!/bin/bash

# from https://discuss.circleci.com/t/waiting-for-build-to-complete-when-invoked-via-http-api/14989
wait_for_build() {
    CIRCLE_API_TOKEN=$1
    BUILD_URL=$2
    TIMEOUT_IN_SECS=$3
    POLL_INTERVAL_IN_SECS=15

    # Pipe syserr message to /dev/null, we don't care we're not trying to change the system date.
    # Use cat to suppress exit code.
    timeout_time=$(date -s "${TIMEOUT_IN_SECS} seconds" +%s 2> /dev/null | cat)
    for i in `seq 1 $(($TIMEOUT_IN_SECS / $POLL_INTERVAL_IN_SECS))`; do
        echo "[Try ${i}] Waiting for build: $BUILD_URL"

        result=$(curl --user ${CIRCLE_API_TOKEN}: \
            --fail \
            $BUILD_URL)
        lifecycle=$(echo $result | jq --raw-output --exit-status '.lifecycle')
        if [ $lifecycle == 'finished' ]; then
            # We've got to a final state, eg. success, failed, canceled etc.
            break
        fi

        if [ $(date +%s) > timeout_time ]; then
            # We've hit a roadblock, let's get out of here and not tie things up any longer.
            break;
        fi
        
        sleep $POLL_INTERVAL_IN_SECS
    done
}

# wait_for_build "<my api token>" "<my build url to check>" "<max timeout in secs>"

echo =============== TRIGGER CLI BUILD ===============
# will run build and return build number, which we need to construct the endpoint for blocking
BUILD_NUMBER=$(curl -X POST https://circleci.com/api/v1.1/project/github/purduesigbots/pros-cli?circle-token=$CLI_TOKEN | jq --raw-output --exit-status '.build_number)

echo =============== WAITING FOR BUILD TO COMPLETE ===============
./macos/wait_for_build $CLI_TOKEN https://circleci.com/api/v1.1/project/github/purduesigbots/pros-cli/$BUILD_NUMBER 3600
