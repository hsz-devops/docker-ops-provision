#FROM williamyeh/ansible:alpine3
#FROM williamyeh/ansible:alpine3-onbuild
#FROM scottmiller171/ansible-docker-images:ubuntu-14.04
#FROM williamyeh/ansible:ubuntu14.04
FROM williamyeh/ansible:ubuntu14.04-onbuild

# https://github.com/William-Yeh/docker-ansible
# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK      playbook.yml
ENV PLAYBOOK      /tmp/playbook-t.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

## ==> Executing Ansible (with a simple wrapper)...
#RUN ansible-playbook-wrapper
##https://www.ctl.io/developers/blog/post/dockerfile-entrypoint-vs-cmd/
#CMD ["/bin/bash",""]
