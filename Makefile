IMAGE_NAME := strelga/docker-dante
VERSION=$(shell cat ./VERSION)

# -------------------------------------
# setup targets
# -------------------------------------
.PHONY: setup-docker-volume
setup-docker-volume:
	SERVICE_NAME=$$SERVICE_NAME ./tools/setup_docker_volume

.PHONY: setup-systemd-service
setup-systemd-service:
	SERVICE_NAME=$$SERVICE_NAME; \
	make setup-docker-volume && \
	cp ./tools/docker-dante@.service /etc/systemd/system/ && \
	systemctl enable --now docker-openvpn@$$SERVICE_NAME.service

.PHONY: run-docker
run-docker:
	SERVICE_NAME=$$SERVICE_NAME ./tools/run_docker

# -------------------------------------
# release targets
# -------------------------------------
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
