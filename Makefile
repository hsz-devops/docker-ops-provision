DH_ID=highskillz/ops-provision

TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

#BUILD_CACHE=--no-cache
# --force-rm

build: build-ubuntu

build-all: build-alpine build-ubuntu

build-alpine:
	cd src.alpine; \
	docker build $(BUILD_CACHE) -t $(DH_ID):alpine             .

build-ubuntu:
	cd src.ubuntu; \
	docker build $(BUILD_CACHE) -t $(DH_ID):ubuntu -t $(DH_ID) .

push:
	docker push $(DH_ID)

docker-rmi:
	docker rmi $(DH_ID)

docker-rmi--purge-in-dev:
	#eval $(docker-machine env)
	docker rmi $(DH_ID)                              || true
	docker rm `docker ps -a -q`                      || true
	docker rmi `docker images -q -f dangling=true`   || true
	docker ps -a
	docker volume ls
	docker images

shell:
	docker run -it --rm $(DH_ID)
