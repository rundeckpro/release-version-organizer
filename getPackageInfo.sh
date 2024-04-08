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

AUTH="${APITOKEN}"

getPackageDetails() {
    local QUERY=$1
    curl -s -H 'accept: application/json' \
    "https://packagecloud.io/api/v1/repos/${ORG}/${REPO}/search.json?q=${QUERY}"
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
    local WAR_SHA=$(echo "$PACKAGE_DETAILS" | jq -r ".[] | select(.filename | endswith(\".war\")) | .sha256sum")

    PACKAGE_DETAILS=$(getPackageDetails "$RPM_NAME")
    local RPM_URL=$(echo "$PACKAGE_DETAILS" | jq -r ".[].download_url")
    local RPM_SHA=$(echo "$PACKAGE_DETAILS" | jq -r ".[] | select(.filename | endswith(\".rpm\")) | .sha256sum")

    PACKAGE_DETAILS=$(getPackageDetails "$DEB_NAME")
    local DEB_URL=$(echo "$PACKAGE_DETAILS" | jq -r ".[].download_url")
    local DEB_SHA=$(echo "$PACKAGE_DETAILS" | jq -r ".[] | select(.filename | endswith(\".deb\")) | .sha256sum")

    echo "WAR_URL='$WAR_URL'"
    echo "WAR_SHA='$WAR_SHA'"
    echo "RPM_URL='$RPM_URL'"
    echo "RPM_SHA='$RPM_SHA'"
    echo "DEB_URL='$DEB_URL'"
    echo "DEB_SHA='$DEB_SHA'"
}


fetchAndDisplayPackageDetails
