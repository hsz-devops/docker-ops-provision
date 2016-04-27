FROM williamyeh/ansible:alpine3-onbuild


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
CMD ["/bin/bash"]
