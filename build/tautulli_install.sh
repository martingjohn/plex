#!/bin/bash

mkdir -p /etc/Tautulli \
         /data/Tautulli \
         /opt/Tautulli

git clone https://github.com/Tautulli/Tautulli.git /opt/Tautulli

id tautulli || addgroup --gid $TAUTULLI_GID tautulli && adduser --uid $TAUTULLI_UID --no-create-home --system tautulli --ingroup tautulli

chown -R tautulli:tautulli /opt/Tautulli
chown -R tautulli:tautulli /etc/Tautulli
chown -R tautulli:tautulli /data/Tautulli
