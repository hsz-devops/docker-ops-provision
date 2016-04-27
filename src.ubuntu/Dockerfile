FROM williamyeh/ansible:ubuntu14.04-onbuild
#FROM scottmiller171/ansible-docker-images:ubuntu-14.04

ENV  PLAYBOOK     install-plays.yml
#ENV  REQUIREMENTS install-reqs.yml
#ENV  INVENTORY    install-inv.ini
#ENV  INVENTORY    "/etc/ansible/hosts"

COPY ./install-*.* /tmp/

WORKDIR /tmp
RUN ansible-playbook-wrapper

VOLUME ["/data"]
WORKDIR /data

#https://www.ctl.io/developers/blog/post/dockerfile-entrypoint-vs-cmd/
CMD ["/bin/bash",""]
