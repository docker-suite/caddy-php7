DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
ROOT:=$(strip $(abspath $(DIR)/..))
PROJECT_NAME:=$(strip $(shell basename $(ROOT)))
PROJECT_VERSION:=example
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)
CONTAINER:=$(PROJECT_NAME)-$(PROJECT_VERSION)


build:
	# Build caddy image
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfile \
		--tag $(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(DIR)

run: build
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-p 2015:2015 \
    	--name $(CONTAINER) \
		$(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(ARGS)
