# adapted from [ williamyeh/ansible:ubuntu14.04-onbuild ]
# "ONBUILD version" because:
# - updates some SSL stuff everytime is used in another image
# - copies . to /tmp/ops

# pull base image
FROM ubuntu:16.04

MAINTAINER HighSkillz <webdev@highskillz.com>

#LABEL \
#  version=
#  description=

# Not adding Ansible PPA because it doesn't (?yet?) support xenial
RUN \
    DEBIAN_FRONTEND=noninteractive  apt-get    update  && \
    DEBIAN_FRONTEND=noninteractive  apt-get -y install \
          apt-utils \
          apt-transport-https \
          lsb-release \
    && \
    DEBIAN_FRONTEND=noninteractive  apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive  apt-get -y install  \
          bash \
          less \
          nano \
          \
          curl \
          wget \
          \
          unzip \
          \
          python \
          python-pip \
          python3 \
          python3-pip \
          \
          golang \
    && \
    pip  install --upgrade pip wheel setuptools && \
    pip3 install --upgrade pip wheel setuptools && \
    \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    DEBIAN_FRONTEND=noninteractive  apt-get -y install  \
          nodejs \
    && \
    echo "===> Installing Ansible..."  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y ansible  && \
    \
    \
    echo "===> Removing APT stuff ..."  && \
    apt-get autoremove --purge   && \
    apt-get autoclean            && \
    rm -rf /var/lib/apt/lists/*  && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    echo 'localhost' > /etc/ansible/hosts


COPY ansible-playbook-wrapper /usr/local/bin/

ONBUILD  RUN  DEBIAN_FRONTEND=noninteractive  apt-get update   && \
              echo "===> Updating TLS certificates..."         && \
              DEBIAN_FRONTEND=noninteractive apt-get install -y openssl ca-certificates

ONBUILD  COPY  .  /tmp/ops
ONBUILD  WORKDIR  /tmp/ops
ONBUILD  RUN  \
              echo "===> Diagnosis: host information..."  && \
              ansible -c local -m setup all

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
