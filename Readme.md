# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) caddy-php7
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-php7/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/caddy-php7/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/caddy-php7.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/caddy-php7.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/caddy-php7/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/caddy-php7/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

A [Caddy][caddy] server and php7 docker image built on top of the latest [Alpine runit][alpine-runit] container with [runit][runit] process supervisor.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes
- /etc/caddy
- /etc/caddy/certificates
- /var/www
- /var/log

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports
- 80
- 443
- 2015

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Available environment variables

- caddy :https://github.com/docker-suite/caddy#-available-environment-variables
- php7: https://github.com/docker-suite/alpine-php7#-available-environment-variables

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use this image

For more info on caddy, visit: https://github.com/docker-suite/caddy/blob/master/Readme.md  
For more info on alpine-php7, visit: https://github.com/docker-suite/alpine-php7/blob/master/Readme.md  


[caddy]: https://github.com/docker-suite/caddy/
[alpine-php7]: https://github.com/docker-suite/alpine-php7/
[alpine-runit]: https://github.com/docker-suite/alpine-runit/
[runit]: http://smarden.org/runit/
