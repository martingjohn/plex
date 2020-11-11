#!/usr/bin/with-contenv bash

echo "Mounting $RCLONE_REMOTE to $RCLONE_MOUNT"

mkdir -p "$RCLONE_MOUNT"
rclone mount --allow-other "$RCLONE_REMOTE" "$RCLONE_MOUNT"
