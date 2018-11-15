#!/bin/bash

#installs
cd /tmp
./rclone_install.sh
./plex_install.sh

#rclone mounts
mkdir -p /mnt/rclone/JC
PLEX_OPTIONS="--allow-other --read-only --stats 600s -v"

rclone mount $PLEX_OPTIONS --log-file=/root/JC.log jottacloud:Plex /mnt/rclone/JC &
#rclone mount $PLEX_OPTIONS --log-file=/root/JC_cache.log --cache-db-purge JC_cache: /mnt/rclone/JC_cache &
#rclone mount $PLEX_OPTIONS --log-file=/root/JC_encrypt.log Encrypt_jottacloud: /mnt/rclone/E_JC &


#Plex

home="$(echo ~plex)"
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/usr/lib/plexmediaserver/Library/Application Support"
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR:-${home}/Library/Application Support}"
export PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
export PLEX_MEDIA_SERVER_INFO_VENDOR=Docker
export PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container"
export PLEX_MEDIA_SERVER_INFO_MODEL=$(uname -m) 
export PLEX_MEDIA_SERVER_INFO_PLATFORM_VERSION=$(uname -r) 

export LD_LIBRARY_PATH=${PLEX_MEDIA_SERVER_HOME}
cd ${PLEX_MEDIA_SERVER_HOME}
./Plex\ Media\ Server &

