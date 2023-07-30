DOCKER_USERNAME ?= wurly
DOCKER_IMAGE_NAME ?= builder_esp32_esp-idf-v5

.PHONY: build
build:
	docker build . -t $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):latest \
				--build-arg USER_NAME=${DOCKER_USERNAME} \
				--build-arg GROUP_NAME=${DOCKER_USERNAME} \
				--build-arg IMAGE_NAME=${DOCKER_IMAGE_NAME}

.PHONY: push
push:
	docker login -u $(DOCKER_USERNAME)
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):latest

.PHONY: ci-cd
ci-cd: build push