# srizzling's dotfiles

## Motivation

I was finding that my zsh start up times were getting slower and slower - and quite frankly needed some TLC - I had found out the original [parent repo](https://github.com/caarlos0/dotfiles) (that I forked from) author had switched to fish (see repo ][here](https://github.com/caarlos0/dotfiles.fish)) I decided to fork his work thier and make it my own!

## Installation

### Dependancies

Ensure the following is available (the scripts take care of the rest hopefully):

- git
- curl
- sudo

### Install

After the Dependancies are installed then run these steps:

```bash
$ git clone git@github.com:srizzling/.dotfiles.fish.git ~/.dotfiles.fish
$ cd ~/.dotfiles.fish
$ ./install.sh
```

### Update

To update, you just need to git pull and run the bootstrap script again:

```
$ cd ~/.dotfiles.fish
$ git pull origin main
$ ./install.sh
```
