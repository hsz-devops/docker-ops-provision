# v2.2.0    2018-03-04     webmaster@highskillz.com

TAG_VERSION=180903a

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date -u +"%Y%m%d_%H%M%S%Z")

BUILD_CACHE=
#BUILD_CACHE=--no-cache --force-rm

default: build

include ./Makefile.provis

# --------------------------------------------------------------------------
build: build-ubuntu

all: build-alpine build-ubuntu

#build-alpine: build-alpine-base build-alpine-provis
#build-alpine: build-alpine-provis
build-ubuntu: build-ubuntu-provis

pull: pull-alpine pull-ubuntu
#pull-alpine: pull-alpine-provis
pull-ubuntu: pull-ubuntu-provis

push: push-alpine push-ubuntu
#push-alpine: push-alpine-provis
push-ubuntu: push-ubuntu-provis

# --------------------------------------------------------------------------
clean-junk:
	docker rm -v     `docker ps -aq -f status=exited`      || true
	docker rmi       `docker images -q -f dangling=true`   || true
    docker volume rm `docker volume ls -qf dangling=true | grep -v "ansible_" | grep -v "^infra" |grep -v "state" |grep -v "persist" |grep -v "vol_"`  || true

# clean-images:
# 	docker rmi $(DH_ID_base):alpine  $(DH_ID):alpine   || true
# 	docker rmi $(DH_ID_base):ubuntu  $(DH_ID):ubuntu   || true
#
# d-rmi: clean-images clean-junk

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a

# --------------------------------------------------------------------------
