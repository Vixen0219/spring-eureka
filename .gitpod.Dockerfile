FROM gitpod/workspace-full:latest
FROM gitpod/workspace-mysql

USER root

# Install custom tools, runtime, etc.

RUN ["apt-get", "update"]

RUN ["apt-get", "install", "-y", "zsh"]
RUN ["apt-get", "install", "fonts-powerline"]

RUN sudo apt-get install curl gnupg apt-transport-https -y

RUN sudo apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA" \
    && sudo apt-key adv --keyserver "keyserver.ubuntu.com" --recv-keys "F77F1EDA57EBB1CC" \
    && sudo curl -1sLf 'https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey' | sudo apt-key add - \
    && sudo echo 'deb http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list \
    && sudo echo 'deb-src http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list \
    && sudo echo 'deb https://packagecloud.io/rabbitmq/rabbitmq-server/debian/ buster main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list \
    && sudo echo 'deb-src https://packagecloud.io/rabbitmq/rabbitmq-server/debian/ buster main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list \
    && sudo apt-get update -y \
    && sudo apt-get install -y erlang-base \
       erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
       erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
       erlang-runtime-tools erlang-snmp erlang-ssl \
       erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
RUN sudo apt-get install rabbitmq-server -y --fix-missing

COPY lighthouse.conf /etc
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
RUN sudo cat /etc/lighthouse.conf >> /home/gitpod/.bashrc
USER gitpod


# ENV ZSH_THEME random

# Install Oh-My-Zsh
# RUN wget https://github.com/dbestevez/agitnoster-theme
# RUN cd agitnoster-theme
# RUN sudo sh ./install.sh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN wget https://github.com/DylanDelobel/agnoster-timestamp-newline-zsh-theme/blob/master/agnoster-timestamp-newline.zsh-theme
RUN cp agnoster-timestamp-newline.zsh-theme ~/.oh-my-zsh/custom/themes/

ENV ZSH_THEME agnoster-timestamp-newline
  # start zsh

  CMD [ "zsh" ]
