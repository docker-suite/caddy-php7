FROM dsuite/caddy-php7:7.4

ENV PLUGINS="http.git"

RUN bash -c '/usr/local/bin/caddy-install.sh'

COPY /rootfs /
