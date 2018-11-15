FROM ubuntu:bionic

ENV RCLONE_BETA=yes \
    RCLONE_VERSION=latest \
    PLEX_UID=101 \
    PLEX_GID=101 \
    TAUTULLI_UID=102 \
    TAUTULLI_GID=102


RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            --no-install-recommends \
            bsdtar \
            ca-certificates \
            curl \
            fuse \
            git \
            python \
            python-setuptools \
            sudo \
            tzdata \
            xmlstarlet \
 && echo

ADD rclone_install.sh /tmp
ADD plex_install.sh /tmp
ADD start_up.sh /tmp
ADD tautulli_install.sh /tmp

CMD ["/bin/bash"]
