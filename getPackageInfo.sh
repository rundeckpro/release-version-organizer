#!/bin/bash

if [ $# -lt 5 ]; then
    echo "Usage: $0 <repo> <pkg> <vers> <date> <tag>"
    exit 1
fi

ORG="pagerduty"
REPO="${1}"
PKG="${2}"
VERS="${3}"
DATE="${4}"
TAG="${5}"

AUTH="${PKGCLD_APITOKEN}"

getPackageDetails() {
    local QUERY=$1
    curl -s -q -H 'accept: application/json' \
    curl "https://${AUTH}:@packagecloud.io/api/v1/repos/${ORG}/${REPO}/search.json?q=${QUERY}"
}

warName() {
    if [ "${TAG}" = "GA" ] ; then
        echo "${PKG}-${VERS}-${DATE}.war"
    else
        echo "${PKG}-${VERS}-${DATE}-${TAG}.war"
    fi
}

debName() {
    if [ "${TAG}" = "GA" ] ; then
        echo "${PKG}_${VERS}.${DATE}-1_all.deb"
    else
        echo "${PKG}_${VERS}.${DATE}~${TAG}-1_all.deb"
    fi
}

rpmName() {
    if [ "${TAG}" = "GA" ] ; then
        echo "${PKG}-${VERS}.${DATE}-1.noarch.rpm"
    else
        echo "${PKG}-${VERS}.${DATE}~${TAG}-1.noarch.rpm"
    fi
}

fetchAndDisplayPackageDetails() {
    local WAR_NAME=$(warName)
    local DEB_NAME=$(debName)
    local RPM_NAME=$(rpmName)

    local PACKAGE_DETAILS=$(getPackageDetails "$WAR_NAME")
    local WAR_URL=$(echo "$PACKAGE_DETAILS" | jq -r ".[].download_url")

    PACKAGE_DETAILS=$(getPackageDetails "$RPM_NAME")
    local RPM_URL=$(echo "$PACKAGE_DETAILS" | jq -r ".[].download_url")
    local RPM_SHA=$(echo "$PACKAGE_DETAILS" | jq -r ".[] | select(.filename | endswith(\".rpm\")) | .sha256sum")

    PACKAGE_DETAILS=$(getPackageDetails "$DEB_NAME")
    local DEB_URL=$(echo "$PACKAGE_DETAILS" | jq -r ".[].download_url")
    local DEB_SHA=$(echo "$PACKAGE_DETAILS" | jq -r ".[] | select(.filename | endswith(\".deb\")) | .sha256sum")

    echo "Downloading $WAR_NAME from $WAR_URL" 1>&2
    local WAR_FILE=$(mktemp)
    curl -s -L -o "$WAR_FILE" "$WAR_URL"

    if [ ! -f "$WAR_FILE" ]; then
        echo "Failed to download $WAR_NAME" 1>&2
        exit 2
    else
        local WAR_SHA=$(shasum -a 256 "$WAR_FILE" | awk '{print $1}')
        echo "Computed WAR SHA: $WAR_SHA" 1>&2
        rm -f "$WAR_FILE"
    fi

    echo "WAR_URL='$WAR_URL'"
    echo "WAR_SHA='$WAR_SHA'"
    echo "RPM_URL='$RPM_URL'"
    echo "RPM_SHA='$RPM_SHA'"
    echo "DEB_URL='$DEB_URL'"
    echo "DEB_SHA='$DEB_SHA'"
}


fetchAndDisplayPackageDetails
