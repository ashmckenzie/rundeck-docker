NAME=rundeck
DOCKERFILE=Dockerfile
IMAGE_NAME=${DOCKER_HUB_USERNAME}/${NAME}

CURRENT_WORKING_DIR=$(shell pwd)

build:
	docker build -f ${DOCKERFILE} -t ${IMAGE_NAME}:latest .

run: build
	docker run --rm -ti -p 4441:4440 -v ${CURRENT_WORKING_DIR}/tmp:/config ${IMAGE_NAME}:latest

shell: build
	docker run --rm -ti -p 4441:4440 -v ${CURRENT_WORKING_DIR}/tmp:/config ${IMAGE_NAME}:latest bash

attach:
	docker exec -ti `docker ps | grep '${IMAGE_NAME}:latest' | awk '{ print $$1 }'` bash

push: build
	docker tag ${IMAGE_NAME}:latest registry.apps.mine.nu/${IMAGE_NAME}:latest && docker push registry.apps.mine.nu/${IMAGE_NAME}:latest
