# Makefile for a Vue project with Docker

# Variables
PACKAGE_MANAGER = npm
START = serve
BUILD = build
TEST = test
INSTALL = install
DOCKER_IMAGE = contact-list-vue
DOCKER_CONTAINER = contact-list-vue-container
DOCKER_PORT = 8080
HOST_PORT = 8080

# Targets
.PHONY: all install start build test clean docker-build docker-run docker-stop docker-clean docker-dev

all: install start

install:
	$(PACKAGE_MANAGER) $(INSTALL)

start:
	$(PACKAGE_MANAGER) run $(START)

build:
	$(PACKAGE_MANAGER) run $(BUILD)

test:
	$(PACKAGE_MANAGER) run $(TEST)

clean:
	rm -rf node_modules dist

docker-build:
	docker build -t $(DOCKER_IMAGE) .

docker-run: docker-stop
	docker run -d -p $(HOST_PORT):$(DOCKER_PORT) --name $(DOCKER_CONTAINER) $(DOCKER_IMAGE)

docker-stop:
	-docker stop $(DOCKER_CONTAINER)
	-docker rm $(DOCKER_CONTAINER)

docker-clean: docker-stop
	-docker rmi $(DOCKER_IMAGE)

docker-dev: docker-stop
	docker run -it --rm -p $(HOST_PORT):$(DOCKER_PORT) -v $(shell pwd)/src:/app/src -v $(shell pwd)/public:/app/public -v $(shell pwd)/package.json:/app/package.json -v $(shell pwd)/package-lock.json:/app/package-lock.json -v /app/node_modules --name $(DOCKER_CONTAINER) $(DOCKER_IMAGE) npm run serve
