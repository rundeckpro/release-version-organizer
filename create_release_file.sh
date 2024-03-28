#!/bin/bash

VERSION=$1
PACKAGE_TYPE=$2
RELEASE_DATE=$3
RPM_URL=$4
WAR_SHA=$5
DEB_SHA=$6
RPM_SHA=$7
DEB_URL=$8
WAR_URL=$9

# Use the variables in the JSON content
cat <<EOF > ${PACKAGE_TYPE}-downloads/${VERSION}.json
{
    "versionNumber": "${VERSION}",
    "packageType": "${PACKAGE_TYPE}",
    "releaseDate": "${RELEASE_DATE}",
    "installs": [
        {
            "name": "centos",
            "downloadUrl": "${RPM_URL}",
            "sha": "${RPM_SHA}"
        },
        {
            "name": "docker",
            "downloadUrl": "https://hub.docker.com/layers/rundeck/rundeck/SNAPSHOT/images/sha256-289dfcdf2a911a468ce2bf240d55828c5cf2cf6255181112d61be1290fabf234?context=explore"
        },
        {
            "name": "debian",
            "downloadUrl": "${DEB_URL}",
            "sha": "${DEB_SHA}"
        },
        {
            "name": "fedora",
            "downloadUrl": "${RPM_URL}",
            "sha": "${RPM_SHA}"
        },
        {
            "name": "redhat",
            "downloadUrl": "${RPM_URL}",
            "sha": "${RPM_SHA}"
        },
        {
            "name": "rpm",
            "downloadUrl": "${RPM_URL}",
            "sha": "${RPM_SHA}"
        },
        {
            "name": "windows",
            "downloadUrl": "${WAR_URL}",
            "sha": "${WAR_SHA}"
        },
        {
            "name": "ubuntu",
            "downloadUrl": "${DEB_URL}",
            "sha": "${DEB_SHA}"
        },
        {
            "name": "java",
            "downloadUrl": "${WAR_URL}",
            "sha": "${WAR_SHA}"
        }
    ]
}
EOF
