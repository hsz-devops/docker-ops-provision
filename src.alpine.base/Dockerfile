# adapted from [ williamyeh/ansible:alpine3-onbuild ]
# "ONBUILD version" because:
# - updates some SSL stuff everytime is used in another image
# - copies . to /tmp/ops

# pull base image
FROM alpine:3.4

MAINTAINER HighSkillz <webdev@highskillz.com>

# golang is not installed in the alpine version

# To preserve the behaviour of pip==pip2 we need to pay attention to
# the order in which things are installed.
# This is the reason for us to
#       install pip3
#       remove $(which pip), and then
#       reinstall pip2
# Nevertheless, we use pip2 on the rest of the script "just in case"

RUN \
    echo "===> Updating TLS certificates..."         && \
    apk --update add \
            openssl \
            ca-certificates \
    && \
    \
    echo "===> Adding Python runtime..."  && \
    apk --update add \
            python py-pip \
            python3 \
        && \
    echo "===> Adding usefull packages for devops shell-works..."  && \
    apk --update add \
            openssh-client \
            \
            bash \
            less \
            nano \
            \
            curl \
            wget \
            \
            unzip \
            \
        && \
    echo "===> Configuring Python and PIP..."  && \
    python  -m ensurepip && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    \
    pip3 install --upgrade pip setuptools wheel && \
    rm $(which pip) && \
    pip2 install --upgrade pip setuptools wheel && \
    echo Making sure pip is set to python2 && \
    pip --version | grep "python 2\."  && \
    \
    apk --update add --virtual build-dependencies \
            python-dev \
            python3-dev \
            openssl-dev \
            build-base  \
            libffi-dev \
        && \
    pip2 install --upgrade cffi && \
    pip3 install --upgrade cffi && \
    \
    echo "===> Installing NodeJS..."  && \
    apk --update add \
            nodejs \
    && \
    echo "===> Adding GO ..."  && \
    apk --update add \
            go \
    && \
    \
    echo "===> Installing Ansible..."  && \
    pip2 install ansible                && \
    \
    \
    echo "===> Removing packages ..."  && \
    apk del build-dependencies            && \
    rm -rf \
      "${HOME}/.cache" \
       /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


COPY ansible-playbook-wrapper /usr/local/bin/

ONBUILD  RUN  \
              echo "===> Updating TLS certificates..."         && \
              apk --update add openssl ca-certificates

ONBUILD  COPY  .  /tmp/ops
ONBUILD  WORKDIR  /tmp/ops
ONBUILD  RUN  \
              echo "===> Diagnosis: host information..."  && \
              ansible -c local -m setup all

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]


