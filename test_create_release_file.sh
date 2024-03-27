#!/bin/bash

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
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "docker",
            "downloadUrl": "https://hub.docker.com/layers/rundeck/rundeck/SNAPSHOT/images/sha256-289dfcdf2a911a468ce2bf240d55828c5cf2cf6255181112d61be1290fabf234?context=explore",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "debian",
            "downloadUrl": "${DEB_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "fedora",
            "downloadUrl": "${RPM_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "redhat",
            "downloadUrl": "${RPM_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "rpm",
            "downloadUrl": "${RPM_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "windows",
            "downloadUrl": "${WAR_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "ubuntu",
            "downloadUrl": "${DEB_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        },
        {
            "name": "java",
            "downloadUrl": "${WAR_URL}",
            "packageSHAs": {
                "war": "${WAR_SHA}",
                "deb": "${DEB_SHA}",
                "rpm": "${RPM_SHA}"
            }
        }
    ]
}
EOF
