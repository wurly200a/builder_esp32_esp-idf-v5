DOCKER_USERNAME ?= wurly
DOCKER_IMAGE_NAME ?= builder_esp32_esp-idf-v5

BUILD_ARGS := --build-arg IMAGE_NAME=${DOCKER_IMAGE_NAME}

.PHONY: build
build:
	docker build -t $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):latest $(BUILD_ARGS) .

.PHONY: push
push:
	docker login -u $(DOCKER_USERNAME)
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):latest

.PHONY: ci-cd
ci-cd: build push

.PHONY: build-tag
build-tag:
	docker build -t $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):$(TAG) $(BUILD_ARGS) .

.PHONY: push-tag
push-tag:
	docker login -u $(DOCKER_USERNAME)
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE_NAME):$(TAG)
