FROM registry.fedoraproject.org/fedora-toolbox:35

RUN sudo dnf upgrade -y && sudo dnf install -y glibc-all-langpacks direnv fish fzf git-delta libX11-xcb libdrm jq pinentry-tty git starship openssh-server && dnf clean all

RUN printf "Port 2222\nListenAddress localhost\nPermitEmptyPasswords yes\n" >> /etc/ssh/sshd_config \
	&& /usr/libexec/openssh/sshd-keygen rsa \
	&& /usr/libexec/openssh/sshd-keygen ecdsa \
	&& /usr/libexec/openssh/sshd-keygen ed25519

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
    cd ~/.asdf && \
    git checkout v0.9.0

RUN git clone https://github.com/garabik/grc.git ~/.grc && \
	cd ~/.grc && \
	chmod +x ./install.sh && \
	./install.sh

ADD . /.dotfiles.fish
RUN cd .dotfiles.fish && fish bootstrap.fish

SHELL ["fish"]