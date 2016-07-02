# v1.5.0    2016-06-11     webmaster@highskillz.com

TAG_VERSION=160701f

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

BUILD_CACHE=
#BUILD_CACHE=--no-cache --force-rm

default:

include ./Makefile.base
include ./Makefile.provis

# --------------------------------------------------------------------------
build: build-ubuntu

all: build-alpine build-ubuntu

#build-alpine: build-alpine-base build-alpine-provis
build-alpine: build-alpine-base
build-ubuntu: build-ubuntu-base build-ubuntu-provis

pull: pull-alpine pull-ubuntu
#pull-alpine: pull-alpine-base  pull-alpine-provis
pull-alpine: pull-alpine-base
pull-ubuntu: pull-ubuntu-base  pull-ubuntu-provis

push: push-alpine push-ubuntu
#push-alpine: push-alpine-base  push-alpine-provis
push-alpine: push-alpine-base
push-ubuntu: push-ubuntu-base  push-ubuntu-provis

# --------------------------------------------------------------------------
clean-junk:
	docker rm        `docker ps -aq -f status=exited`      || true
	docker rmi       `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`  || true

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

# # --------------------------------------------------------------------------
# webcache-copy: webcache-copy-ubuntu webcache-copy-alpine

# webcache-copy-ubuntu:
# 	cp -a ./_web_cache ./src.ubuntu

# webcache-copy-alpine:
# 	cp -a ./_web_cache ./src.alpine
