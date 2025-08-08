{ config, pkgs, ... }:

{
  # Configure lsd via config file
  home.file.".config/lsd/config.yaml".text = ''
    # Display
    classic: false
    blocks:
      - permission
      - user
      - group
      - size
      - date
      - name
    color:
      when: auto
      theme: custom
    date: date
    dereference: false
    display: all
    icons:
      when: auto
      theme: fancy
      separator: " "
    ignore-globs: []
    indicators: false
    layout: grid
    recursion:
      enabled: false
      depth: 1
    size: short
    permission: rwx
    sorting:
      column: name
      reverse: false
      dir-grouping: first
    no-symlink: false
    total-size: false
    hyperlink: never
  '';

  # Add Catppuccin Macchiato theme for lsd
  home.file.".config/lsd/colors.yaml".text = ''
    user: "#c6a0f6"
    group: "#b7bdf8"
    permission:
      read: "#a6da95"
      write: "#eed49f"
      exec: "#ee99a0"
      exec-sticky: "#c6a0f6"
      no-access: "#a5adcb"
      octal: "#8bd5ca"
      acl: "#8bd5ca"
      context: "#91d7e3"
    date:
      hour-old: "#8bd5ca"
      day-old: "#91d7e3"
      older: "#7dc4e4"
    size:
      none: "#a5adcb"
      small: "#a6da95"
      medium: "#eed49f"
      large: "#f5a97f"
    inode:
      valid: "#f5bde6"
      invalid: "#a5adcb"
    links:
      valid: "#f5bde6"
      invalid: "#a5adcb"
    tree-edge: "#b8c0e0"
    git-status:
      default: "#cad3f5"
      unmodified: "#a5adcb"
      ignored: "#a5adcb"
      new-in-index: "#a6da95"
      new-in-workdir: "#a6da95"
      typechange: "#eed49f"
      deleted: "#ed8796"
      renamed: "#a6da95"
      modified: "#eed49f"
      conflicted: "#ed8796"
  '';
}