#!/usr/bin/env make

.ONESHELL:
.DELETE_ON_ERROR:
.ALWAYS:

DOCKER_IMAGE_NAME  := tzrlk/valheim-server-aws
DOCKER_IMAGE_TAG   ?= latest
LLOESCHE_IMAGE_TAG ?= latest

.build/:
	mkdir -p ${@}

#: Triggers a build of the docker image if necessary.
docker: .build/image
.build/image: \
		Dockerfile \
		.dockerignore \
		$(wildcard bin/*) \
		$(wildcard etc/*) \
		| .build/
	docker build \
		--iidfile ${@} \
		--build-arg LLOESCHE_VERSION=${LLOESCHE_IMAGE_TAG} \
		--tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} \
		.

# Push the image to docker hub
push: .build/pushed
.build/pushed: \
		.build/image
	docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
