FROM gitpod/workspace-full:latest
FROM gitpod/workspace-mysql

USER root

# Install custom tools, runtime, etc.

RUN ["apt-get", "update"]

RUN ["apt-get", "install", "-y", "zsh"]
RUN ["apt-get", "install", "fonts-powerline"]


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