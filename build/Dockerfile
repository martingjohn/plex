FROM ubuntu:bionic

ENV RCLONE_BETA=yes
ENV RCLONE_VERSION=latest

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            --no-install-recommends \
            bsdtar \
            ca-certificates \
            curl \
            fuse \
            xmlstarlet \
 && echo

ADD rclone_install.sh /tmp
ADD plex_install.sh /tmp
ADD start_up.sh /tmp

CMD ["/bin/bash"]
