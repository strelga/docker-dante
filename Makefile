IMAGE_NAME := strelga/docker-dante
VERSION=$(shell cat ./VERSION)

.PHONY: release
docker-release: docker-build-tag docker-push-latest-tag

.PHONY: docker-build-tag
docker-build-tag:
	docker build -t $(IMAGE_NAME):$(VERSION) . && \
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(VERSION) && \
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest

.PHONY: docker-push-latest-tag
docker-push-latest-tag:
	docker push $(IMAGE_NAME):$(VERSION) && \
	docker push $(IMAGE_NAME):latest

.PHONY: build
build:
	docker build .

.PHONY: patch minor major
patch minor major:
	NEW_VERSION=$$(./tools/bump_version $(VERSION) $@) && \
	printf $$NEW_VERSION > ./VERSION && \
	echo "New version $$NEW_VERSION" && \
	git add . && git commit -m $$NEW_VERSION && \
	git tag $$NEW_VERSION -am $$NEW_VERSION && \
	git push && git push origin $$NEW_VERSION
