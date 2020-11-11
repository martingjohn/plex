# plex
Plex with rclone mount built in

Sample docker-compose.yaml file provided which will need editing to suit your needs

Or probably more simply - this can be done with bind mounts and separate containers which probably fits in better with the docker philosophy (you can then also add things like gaps and tautulli)

e.g. docker-compose.yaml

    version: "3.8"
    services:
      rclone:
        image: rclone/rclone
        container_name: rclone
        restart: unless-stopped
        cap_add:
          - SYS_ADMIN
        devices:
          - /dev/fuse
        security_opt:
          - "apparmor:unconfined"
        environment:
          - RCLONE_ALLOW_OTHER=true
          - RCLONE_READ_ONLY=true
          - RCLONE_BUFFER_SIZE=50M
          - RCLONE_FAST_LIST=true
          - RCLONE_VFS_CACHE_MAX_AGE=3h
          - RCLONE_VFS_CACHE_MODE=full
          - RCLONE_VFS_CACHE_POLL_INTERVAL=1m
          - RCLONE_VFS_CACHE_MAX_SIZE=10g
          - RCLONE_CACHE_DIR=/tmp
          - RCLONE_VERBOSE=1
        volumes:
          - ${PWD}/rclone:/config/rclone
          - ${PWD}/tmp:/tmp
          - type: bind
            source: ${PWD}/mnt
            target: /mnt
            bind:
              propagation: shared
        command: ["mount","remote:/Plex","/mnt"]
      plex:
        image: plexinc/pms-docker:plexpass
        container_name: plex-docker
        hostname: plex-docker
        restart: unless-stopped
        ports:
          - 32400:32400/tcp
        volumes:
    #      - /mnt/docker/data/plex/transcode:/transcode
          - /mnt/docker/data/plex:/config
    #      - ${PWD}/metadata:/config
          - ${PWD}/tmp:/tmp
          - type: bind
            source: ${PWD}/mnt
            target: /mnt
            bind:
              propagation: slave
        environment:
          - TZ=Europe/London
    #      - PLEX_UID=112
    #      - PLEX_GID=117
          - ADVERTISE_IP=http://192.168.10.57:32400/
          - ALLOWED_NETWORKS=192.168.10.0/24
          - PLEX_CLAIM=claim-xxxxxxx
      tautulli:
        image: tautulli/tautulli
        container_name: tautulli
        restart: unless-stopped
        ports:
          - 8181:8181/tcp
        volumes:
          - ${PWD}/tautulli_config:/config
        environment:  
          - TZ=Europe/London
      gaps:
        image: housewrecker/gaps
        container_name: gaps-int
        restart: unless-stopped
        ports:
          - 8281:8484/tcp
        volumes:
          - /etc/localtime:/etc/localtime:ro
          - ${PWD}/gaps:/usr/data
    
