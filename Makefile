DH_ID_base=highskillz/ops-base
DH_ID=highskillz/ops-provision

TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

#BUILD_CACHE=--no-cache
# --force-rm

default:

# --------------------------------------------------------------------------
build: build-ubuntu

all: build-alpine build-ubuntu

build-alpine:
	cd src.alpine ;\
	docker build $(BUILD_CACHE) -f Dockerfile.base -t $(DH_ID_base):alpine . ;\
	docker build $(BUILD_CACHE) -f Dockerfile      -t $(DH_ID):alpine      . ;\

build-ubuntu:
	cd src.ubuntu ;\
	docker build $(BUILD_CACHE) -f Dockerfile.base -t $(DH_ID_base):ubuntu . ;\
	docker build $(BUILD_CACHE) -f Dockerfile      -t $(DH_ID):ubuntu      . ;\


# --------------------------------------------------------------------------
pull: pull-alpine pull-ubuntu

pull-alpine:
	docker pull $(DH_ID_base):alpine
	docker pull $(DH_ID):alpine

pull-ubuntu:
	docker pull $(DH_ID_base):ubuntu
	docker pull $(DH_ID):ubuntu

push: push-alpine push-ubuntu

push-alpine:
	docker push $(DH_ID_base):alpine
	docker push $(DH_ID):alpine

push-ubuntu:
	docker push $(DH_ID_base):ubuntu
	docker push $(DH_ID):ubuntu

# --------------------------------------------------------------------------
clean-junk:
	docker rm  `docker ps -aq -f status=exited`      || true
	docker rmi `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`   || true

clean-images:
	docker rmi $(DH_ID_base):alpine  $(DH_ID):alpine         || true
	docker rmi $(DH_ID_base):ubuntu  $(DH_ID):ubuntu         || true

d-rmi: clean-images clean-junk

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a

# --------------------------------------------------------------------------
shell:
	docker run -it --rm $(DH_ID):ubuntu bash

# --------------------------------------------------------------------------
webcache-copy: webcache-copy-ubuntu webcache-copy-alpine

webcache-copy-ubuntu:
	cp -a ./_web_cache ./src.ubuntu

webcache-copy-alpine:
	cp -a ./_web_cache ./src.alpine
