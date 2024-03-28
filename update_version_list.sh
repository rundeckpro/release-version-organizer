#!/bin/bash

JSON_FILE="versionsList.json"

VERSION=$1
RELEASE_DATE=$2


# Validate input parameters
if [[ -z "$VERSION" || -z "$RELEASE_DATE" ]]; then
    echo "Release version and date must be set as params"
    exit 1
fi

jq --arg version_number "$VERSION" --arg release_date "$RELEASE_DATE" \
   '.versions += [{"version_number":$version_number, "release_date":$release_date}]' \
   "$JSON_FILE" > tmp.$$.json && mv tmp.$$.json "$JSON_FILE"
