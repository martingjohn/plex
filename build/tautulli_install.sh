#!/bin/bash

mkdir -p /etc/Tautulli \
         /data/Tautulli \
         /opt/Tautulli

git clone https://github.com/Tautulli/Tautulli.git /opt/Tautulli

addgroup tautulli && sudo adduser --system --no-create-home tautulli --ingroup tautulli
chown -R tautulli:tautulli /opt/Tautulli
chown -R tautulli:tautulli /etc/Tautulli
chown -R tautulli:tautulli /data/Tautulli

cp /tmp/tautulli.service /lib/systemd/system/tautulli.service

