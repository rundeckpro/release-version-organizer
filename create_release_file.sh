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

if [[ "$PACKAGE_TYPE" == "enterprise" ]]; then
    DOCKER_IMAGE="rundeckpro/enterprise:${VERSION}"
elif [[ "$PACKAGE_TYPE" == "community" ]]; then
    DOCKER_IMAGE="rundeck/rundeck:${VERSION}"
fi

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
            "downloadUrl": "docker pull ${DOCKER_IMAGE}"
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
