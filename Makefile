# v2.0.0    2016-06-20     webmaster@highskillz.com

TAG_VERSION=160810a

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

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
	docker rm        `docker ps -aq -f status=exited`      || true
	docker rmi       `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true |grep -v "ansible_" |grep -v "^infra"`  || true

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
