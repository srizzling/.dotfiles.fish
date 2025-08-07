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

  # Configure Aerospace window manager
  home.file.".aerospace.toml".text = ''
    # Place a copy of this config to ~/.aerospace.toml
    # After that, you can edit ~/.aerospace.toml to your liking

    # It's not necessary to copy all keys to your config.
    # If the key is missing in your config, "default-config.toml" will serve as a fallback

    # You can use it to add commands that run after login to macOS user session.
    # 'start-at-login' needs to be 'true' for 'after-login-command' to work
    # Available commands: https://nikitabobko.github.io/AeroSpace/commands
    after-login-command = []

    # You can use it to add commands that run after AeroSpace startup.
    # 'after-startup-command' is run after 'after-login-command'
    # Available commands : https://nikitabobko.github.io/AeroSpace/commands
    after-startup-command = []

    # Start AeroSpace at login
    start-at-login = true

    # Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    # See: https://nikitabobko.github.io/AeroSpace/guide#layouts
    # The 'accordion-padding' specifies the size of accordion padding
    # You can set 0 to disable the padding feature
    accordion-padding = 30

    # Possible values: tiles|accordion
    default-root-container-layout = 'tiles'

    # Possible values: horizontal|vertical|auto
    # 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
    #               tall monitor (anything higher than wide) gets vertical orientation
    default-root-container-orientation = 'auto'

    # Possible values: (qwerty|dvorak)
    # See https://nikitabobko.github.io/AeroSpace/guide#key-mapping
    key-mapping.preset = 'qwerty'

    # Mouse follows focus when focused monitor changes
    # Drop it from your config, if you don't like this behavior
    # See: https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
    # See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

    # Gaps between windows (inner-*) and between monitor edges (outer-*).
    # Possible values:
    # - Constant:     gaps.outer.top = 8
    # - Per monitor:  gaps.outer.top = [{ monitor.main = 16 }, { monitor."some-pattern" = 32 }, 24]
    #                 In this example, 24 is a default value when there is no match.
    #                 Monitor pattern is the same as for 'workspace-to-monitor-force-assignment'.
    #                 See: https://nikitabobko.github.io/AeroSpace/guide#assign-workspaces-to-monitors
    [gaps]
    inner.horizontal = 10
    inner.vertical = 10
    outer.bottom = 100
    outer.left = 100
    outer.right = 100
    outer.top = 100

    # 'main' binding mode declaration
    # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
    # 'main' binding mode must be always presented
    [mode.main.binding]

    # All possible keys:
    # - Letters.        a, b, c, ..., z
    # - Numbers.        0, 1, 2, ..., 9
    # - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
    # - F-keys.         f1, f2, ..., f20
    # - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon, backtick,
    #                   leftSquareBracket, rightSquareBracket, space, enter, esc, backspace, tab
    # - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
    #                   keypadMinus, keypadMultiply, keypadPlus
    # - Arrows.         left, down, up, right

    # All possible modifiers: cmd, alt, ctrl, shift

    # All possible commands: https://nikitabobko.github.io/AeroSpace/commands

    # You can uncomment this line to open up terminal with alt + enter shortcut
    # See: https://nikitabobko.github.io/AeroSpace/commands#exec-and-forget
    alt-enter = 'exec-and-forget open -n /System/Applications/Utilities/Terminal.app'

    # See: https://nikitabobko.github.io/AeroSpace/commands#layout
    alt-comma = 'layout accordion horizontal vertical'
    alt-slash = 'layout tiles horizontal vertical'

    # See: https://nikitabobko.github.io/AeroSpace/commands#focus
    alt-h = 'focus left'
    alt-j = 'focus down'
    alt-k = 'focus up'
    alt-l = 'focus right'

    # See: https://nikitabobko.github.io/AeroSpace/commands#move
    alt-shift-h = 'move left'
    alt-shift-j = 'move down'
    alt-shift-k = 'move up'
    alt-shift-l = 'move right'

    # move window to different monitors
    alt-shift-left = ['move-node-to-monitor --wrap-around left', 'focus-monitor left']
    alt-shift-right = ['move-node-to-monitor --wrap-around right', 'focus-monitor right']

    # See: https://nikitabobko.github.io/AeroSpace/commands#resize
    alt-shift-equal = 'resize smart +50'
    alt-shift-minus = 'resize smart -50'

    # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
    alt-1 = 'workspace 1'
    alt-2 = 'workspace 2'
    alt-b = 'workspace B' # for browser
    alt-c = 'workspace C' # for code
    alt-e = 'workspace E' # for email
    alt-m = 'workspace M' # for music
    alt-n = 'workspace N' # for notes
    alt-s = 'workspace S' # for socials (teams, slack, etc.)
    alt-t = 'workspace T' # for terminal

    # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
    alt-shift-1 = 'move-node-to-workspace 1'
    alt-shift-2 = 'move-node-to-workspace 2'
    alt-shift-b = 'move-node-to-workspace B' # for browser
    alt-shift-c = 'move-node-to-workspace C' # for code
    alt-shift-e = 'move-node-to-workspace E' # for email
    alt-shift-m = 'move-node-to-workspace M' # for music
    alt-shift-n = 'move-node-to-workspace N' # for notes
    alt-shift-s = 'move-node-to-workspace S' # for socials (teams, slack, etc.)
    alt-shift-t = 'move-node-to-workspace T' # for terminal

    # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
    alt-tab = 'workspace-back-and-forth'
    # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
    alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

    # See: https://nikitabobko.github.io/AeroSpace/commands#mode
    alt-shift-semicolon = 'mode service'

    # 'service' binding mode declaration.
    # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
    [mode.service.binding]
    esc = ['reload-config', 'mode main']
    r = ['flatten-workspace-tree', 'mode main'] # reset layout
    #s = ['layout sticky tiling', 'mode main'] # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
    backspace = ['close-all-windows-but-current', 'mode main']
    f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout

    alt-shift-h = ['join-with left', 'mode main']
    alt-shift-j = ['join-with down', 'mode main']
    alt-shift-k = ['join-with up', 'mode main']
    alt-shift-l = ['join-with right', 'mode main']

    [[on-window-detected]]
    if.app-id = 'com.googlecode.iterm2'
    run = "move-node-to-workspace T"

    [[on-window-detected]]
    if.app-id = 'com.mitchellh.ghostty'
    run = "move-node-to-workspace T"

    [[on-window-detected]]
    if.app-id="com.mitchellh.ghostty"
    run= [
      "layout tiling",
    ]

    [[on-window-detected]]
    if.app-id = 'org.mozilla.firefox'
    run = "move-node-to-workspace B"

    [[on-window-detected]]
    if.app-id = 'com.microsoft.teams2'
    run = "move-node-to-workspace S"

    [[on-window-detected]]
    if.app-id = 'com.microsoft.Outlook'
    run = "move-node-to-workspace E"

    [[on-window-detected]]
    if.app-id = 'com.microsoft.VSCode'
    run = "move-node-to-workspace C"

    [[on-window-detected]]
    if.app-id = 'com.spotify.client'
    run = "move-node-to-workspace M"

    [[on-window-detected]]
    if.app-id = 'com.electron.logseq'
    run = "move-node-to-workspace N"

    [[on-window-detected]]
    if.app-id = 'com.tinyspeck.slackmacgap'
    run = "move-node-to-workspace S"

    [[on-window-detected]]
    if.app-id = 'net.whatsapp.WhatsApp'
    run = "move-node-to-workspace S"

    [[on-window-detected]]
    if.app-id = 'com.hnc.Discord'
    run = "move-node-to-workspace S"
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