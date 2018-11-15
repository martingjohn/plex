#!/bin/bash

set -e

if [[ "$RCLONE_VERSION" == "latest" &&
      "$RCLONE_BETA" == "yes" ]]
then
	URL="https://beta.rclone.org/rclone-beta-latest-linux-amd64.zip"
elif [[ "$RCLONE_VERSION" == "latest" &&
        "$RCLONE_BETA" == "no" ]]
then
	URL="https://downloads.rclone.org/rclone-current-linux-amd64.zip"
elif [[ "$RCLONE_BETA" == "yes" ]]
then
	URL="https://beta.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip"
else
	URL="https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip"
fi

curl -L $URL | bsdtar -xvf - --strip-components 1 -C /tmp
cp /tmp/rclone /usr/bin/rclone
chmod 755 /usr/bin/rclone
