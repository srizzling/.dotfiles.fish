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
    # whatsapp-for-linux  # Removed - Linux only package causing build issues
  ];

  # Enable direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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

  # Configure bat
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";  # Use a standard theme for now
      style = "numbers,changes,header";
    };
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
    theme = catppuccin-mocha
    font-size = 23
    font-family = "Iosevka NFM"
    
    window-padding-x = 2,2
    window-padding-y = 1,1
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