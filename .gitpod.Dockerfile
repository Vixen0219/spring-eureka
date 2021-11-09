FROM gitpod/workspace-full:latest
FROM gitpod/workspace-mysql

USER root
# etc.

RUN ["apt-get", "update"]

RUN ["apt-get", "install", "-y", "zsh"]
RUN ["apt-get", "install", "fonts-powerline"]

#RUN wget https://releases.hashicorp.com/vault/1.3.2/vault_1.3.2_linux_amd64.zip && \
#	unzip vault_1.3.2_linux_amd64.zip && \
#	rm -f vault_1.3.2_linux_amd64.zip && \
#	chmod +x vault && \
#	mv vault /usr/local/bin/ && \
#	echo "export VAULT_ADDR=http://127.0.0.1:8200" >> .bashrc
RUN curl https://krypt.co/kr | sh; exit 0
RUN wget -O direnv https://github.com/direnv/direnv/releases/download/v2.21.2/direnv.linux-amd64 && \
	chmod +x direnv && \
	mv direnv /usr/local/bin/
RUN git clone https://github.com/riywo/anyenv .anyenv && \
	echo 'if [ -d $HOME/.anyenv ]' >> .bashrc && \
	echo 'then' >> .bashrc && \
	echo '	export PATH="$HOME/.anyenv/bin:$PATH"' >> .bashrc && \
	echo '	eval "$(anyenv init -)"' >> .bashrc && \
	echo 'fi' >> .bashrc && \
	mkdir -p .anyenv/plugins && \
	git clone https://github.com/znz/anyenv-update.git .anyenv/plugins/anyenv-update
RUN git clone https://github.com/awslabs/git-secrets.git && \
	cd git-secrets && \
	make install && \
	cd .. && \
	rm -rf git-secretss
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
	unzip awscliv2.zip && \
	sudo ./aws/install && \
    rm -f awscliv2.zip && \
    echo '# aws completer' >> .bashrc && \
    echo "complete -C '/usr/local/bin/aws_completer' aws" >> .bashrc
RUN apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
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
