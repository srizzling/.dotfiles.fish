FROM registry.fedoraproject.org/fedora-toolbox:34


RUN sudo dnf install -y glibc-all-langpacks direnv fish fzf git-delta libX11-xcb libdrm jq pinentry-tty git starship grc && dnf clean all 
RUN mkdir -p .dotfiles
ADD dot .dotfiles
ADD install.sh .dotfiles
RUN sudo fish .dotfiles/bootstrap.fish


