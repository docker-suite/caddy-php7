DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_NAME:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)


build: build-7.1 build-7.2 build-7.3 build-7.4

test: test-7.1 test-7.2 test-7.3 test-7.4

push: push-7.1 push-7.2 push-7.3 push-7.4

build-7.1:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=7.1 \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-7.1"
	docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-7.1 \
		--tag $(DOCKER_IMAGE):7.1 \
		$(DIR)/Dockerfiles

build-7.2:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=7.2 \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-7.2"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-7.2 \
		--tag $(DOCKER_IMAGE):7.2 \
		$(DIR)/Dockerfiles

build-7.3:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=7.3 \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-7.3"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-7.3 \
		--tag $(DOCKER_IMAGE):7.3 \
		$(DIR)/Dockerfiles

build-7.4:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=7.4 \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-7.4"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-7.4 \
		--tag $(DOCKER_IMAGE):7.4 \
		$(DIR)/Dockerfiles
	docker tag $(DOCKER_IMAGE):7.4 $(DOCKER_IMAGE):latest


test-7.1: build-7.1
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e PHP_VERSION=7.1 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):7.1

test-7.2: build-7.2
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e PHP_VERSION=7.2 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):7.2

test-7.3: build-7.3
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e PHP_VERSION=7.3 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):7.3

test-7.4: build-7.4
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e PHP_VERSION=7.4 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):7.4

push-7.1: build-7.1
	@docker push $(DOCKER_IMAGE):7.1

push-7.2: build-7.2
	@docker push $(DOCKER_IMAGE):7.2

push-7.3: build-7.3
	@docker push $(DOCKER_IMAGE):7.3

push-7.4: build-7.4
	@docker push $(DOCKER_IMAGE):7.4
	@docker push $(DOCKER_IMAGE):latest

shell-7.1: build-7.1
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_IMAGE):7.1 \
		bash

shell-7.2: build-7.2
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_IMAGE):7.2 \
		bash

shell-7.3: build-7.3
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_IMAGE):7.3 \
		bash

shell-7.4: build-7.4
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_IMAGE):7.4 \
		bash

remove:
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{} || true
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 3 | xargs -I {} docker rmi {} || true

readme:
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater
