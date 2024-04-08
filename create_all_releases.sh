#!/bin/bash

JSON_LIST_PATH="./version.json"
ADAPTED_SCRIPT_PATH="./getPackageInfo.sh"
CREATE_RELEASE_FILE_SCRIPT="./create_release_file.sh"
UPDATE_VERSION_LIST_SCRIPT="./update_version_list.sh"

if [ ! -f "$JSON_LIST_PATH" ]; then
    echo "JSON list file does not exist at the specified path: $JSON_LIST_PATH"
    exit 1
fi

process_version() {
    local REPO_NAME=$1
    local PACKAGE_NAME=$2
    local VERSION=$3
    local DATE=$4
    local TAG=$5

    . $($ADAPTED_SCRIPT_PATH "$REPO_NAME" "$PACKAGE_NAME" "$VERSION" "$DATE" "$TAG")

    $CREATE_RELEASE_FILE_SCRIPT "$VERSION" "$PACKAGE_TYPE" "$DATE" "$RPM_URL" "$WAR_SHA" "$DEB_SHA" "$RPM_SHA" "$DEB_URL" "$WAR_URL"
}

jq -r '.[] | .acf.version_number + " " + .acf.release_date' "$JSON_LIST_PATH" | while read VERSION DATE; do
    # Process for rundeck
    process_version "rundeck" "rundeck" "$VERSION" "$DATE" "GA"
    # Process for rundeckpro
    process_version "rundeckpro" "rundeckpro-enterprise" "$VERSION" "$DATE" "GA"

    # Update the version list once for each version
    $UPDATE_VERSION_LIST_SCRIPT "$VERSION" "$DATE"
done
