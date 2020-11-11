FROM plexinc/pms-docker:plexpass
RUN apt update && \
    apt install -y fuse \
                   unzip && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://rclone.org/install.sh | bash && \
    mkdir  /etc/services.d/rclone-mount
COPY rclone_run.sh /etc/services.d/rclone-mount/run
