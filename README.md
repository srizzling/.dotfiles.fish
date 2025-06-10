# srizzling's dotfiles

## Motivation

The motivation behind this repository stems from the need to optimize and modernize shell configurations. Over time, my zsh setup became increasingly slow and required significant maintenance. Inspired by the work of [caarlos0](https://github.com/caarlos0/dotfiles), who transitioned to the Fish shell (see [dotfiles.fish](https://github.com/caarlos0/dotfiles.fish)), I decided to adopt Fish and build upon their foundation to create a streamlined and efficient configuration tailored to my needs.

## Installation

### Dependencies

Ensure the following is available (the scripts take care of the rest hopefully):

- git
- curl
- sudo

### Install

After the dependencies are installed, run the following steps:

```bash
$ git clone git@github.com:srizzling/.dotfiles.fish.git ~/.dotfiles.fish
$ cd ~/.dotfiles.fish
$ ./bootstrap.fish
```

### Update

To update, you just need to git pull and run the bootstrap script again:

```bash
$ cd ~/.dotfiles.fish
$ git pull origin main
$ ./bootstrap.fish
```

## Features

### Recurring Task Automation

- Automates Homebrew updates and safely commits only changes to the Brewfile.
- Handles rebase conflicts gracefully.

### Hostname-Based Configuration

- Applies specific configurations based on the machine's hostname.

### Versioning and Release Notes

- Uses Git tags for versioning.
- Automatically generates release notes and pushes them to GitHub.

### macOS Wallpaper Automation

- Automates the setup of the wallpaper on macOS.

### Linters

- Includes linters for Fish scripts and other relevant files to ensure code quality.

## Folder Structure

- `brew/`: Homebrew-related scripts and Brewfile.
- `fish/`: Fish shell configuration and functions.
- `fonts/`: Font installation scripts.
- `vim/`: Vim configuration.
- `wallpaper/`: Wallpaper configuration for macOS.

## Troubleshooting

- Ensure all dependencies are installed before running the scripts.
- Check the logs for any errors during the setup process.
