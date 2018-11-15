#!/bin/bash

PREF_FILE="/usr/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml"
TOKEN=$(xmlstarlet sel -T -t -m "/Preferences" -v "@PlexOnlineToken" "$PREF_FILE")
DOWNLOAD_INFO=$(curl -s "https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=$8&distro=ubuntu&X-Plex-Token=${TOKEN}")
FILE=$(echo "$DOWNLOAD_INFO" | xmlstarlet sel -T -t -m "MediaContainer/Release/Package" -v "@file")
FILENAME=$(echo "$DOWNLOAD_INFO" | xmlstarlet sel -T -t -m "MediaContainer/Release/Package" -v "@fileName")
URL="https://plex.tv${FILE}"

find /tmp -name "plexmediaserver*.deb" -mtime +90 -delete

if [[ -f /tmp/$FILENAME ]]
then
        echo Already running $FILENAME
else
        curl -J -L -o /tmp/$FILENAME "$URL"
        dpkg -i --force-confold /tmp/$FILENAME
fi

