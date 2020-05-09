IMAGE_NAME := strelga/docker-dante
VERSION := $(cat ./VERSION)

.PHONY: release
release: build-docker-tag create-git-tag

.PHONY: build-docker-tag
build-docker-tag:
	docker build -t $$IMAGE_NAME:$$VERSION . && \
	docker tag $$IMAGE_NAME:$$VERSION $$IMAGE_NAME:$$VERSION && \
	docker tag $$IMAGE_NAME:$$VERSION $$IMAGE_NAME:latest

.PHONY: build
build:
	docker build .

.PHONY: create-git-tag
create-git-tag:
	git tag $$VERSION -am $$VERSION && \
	git push && git push origin $$VERSION
