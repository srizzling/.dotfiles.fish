{ config, pkgs, profile, ... }:

{
  # Note: allowUnfree is configured at system level when using useGlobalPkgs
  # User packages - migrated from devbox global
  home.packages = with pkgs; [
    # Core utilities (from devbox global)
    bat
    curl
    direnv
    fd
    fzf
    git
    git-absorb
    delta
    grc
    gum
    lsd
    starship
    wget
    python310
    zoxide

    # Additional useful packages
    jq
    ripgrep
    tree
    htop
    
    # Development tools
    gh  # GitHub CLI
    just  # Command runner
    devbox  # Isolated development environments
    claude-code  # Agentic coding tool by Anthropic
    cocogitto  # Conventional commits toolbox
    
    # Fish shell tools
    fishPlugins.fishtape  # TAP-compliant test runner for Fish
    
    # Fonts
    nerd-fonts.iosevka  # Iosevka NFM font for Ghostty
    
    # GUI Applications (official packages from nixpkgs)
    raycast
    aerospace
    # ghostty  # Terminal emulator - build issues on this system
    discord
    vscode
    slack
    spotify
    firefox
    # whatsapp-for-linux  # Removed - Linux only package causing build issues
  ];

  # Enable direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Configure vim editor
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      " Motivated by https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
      set noexrc                             " do NOT read .vimrc within every directory

      syntax on " Turn on color syntax and allow custom Git commit message messages
      autocmd Filetype gitcommit setlocal spell textwidth=72 " Spell check git commit messages and wrap text at column 72
    '';
  };

  # Configure zoxide (better z)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configure fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };


  # Configure GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      version = 1;
      git_protocol = "https";
      prompt = "enabled";
      prefer_editor_prompt = "disabled";
      color_labels = "disabled";
      accessible_colors = "disabled";
      accessible_prompter = "disabled";
      spinner = "enabled";
      aliases = {
        co = "pr checkout";
      };
    };
  };

  # Configure Ghostty terminal
  home.file.".config/ghostty/config".text = ''
    # Font configuration
    font-family = Iosevka NFM
    font-family-bold = Iosevka NFM
    font-family-italic = Iosevka NFM
    font-family-bold-italic = Iosevka NFM
    font-size = 23
    
    # Use Catppuccin Macchiato theme
    theme = catppuccin-macchiato
    
    # Window padding for better visual appearance
    window-padding-x = 10
    window-padding-y = 10
    
    # Enable smooth cursor animation
    cursor-style = block
    cursor-style-blink = true
    
    # macOS specific settings
    macos-option-as-alt = true
    macos-non-native-fullscreen = true
  '';


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