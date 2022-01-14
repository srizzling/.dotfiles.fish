#!/bin/fish

# https://www.cogitri.dev/posts/12-fedora-toolbox/

if ! test -f "/etc/os-release"
    exit 0
end

if ! grep "VARIANT=\"Silverblue\"" /etc/os-release
    exit 0
end

if test -f /run/.containerenv
    exit 0
end

podman build . -t $USER/toolbox:latest
set SCRIPT_DIR (cd (dirname (status -f)); and pwd)

toolbox create -c fedora-toolbox-34 -i $USER/fedora-toolbox
mkdir -p $HOME/.config/systemd/user

if ! test -f "$HOME/.config/systemd/user/toolbox_ssh.service"
    ln -s $SCRIPT_DIR/toolbox_ssh.service $HOME/.config/systemd/user/toolbox_ssh.service
end

systemctl --user daemon-reload
systemctl --user enable --now toolbox_ssh