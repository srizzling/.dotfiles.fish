# Changelog
All notable changes to this project will be documented in this file. See [conventional commits](https://www.conventionalcommits.org/) for commit guidelines.

- - -
## 0.1.0 - 2025-08-07
#### Bug Fixes
- **(aerospace)** 🐛 move focus while moving node - (32c7100) - Sriram Venkatesh
- **(aerospace,ghostty)** 🐛 render windows as seperate tabs - (1727080) - Sriram Venkatesh
- **(direnv)** 🐛 move direnv to fisher plugin - (b4b35c4) - Sriram Venkatesh
- **(ghostty)** 🐛 macos setup delete default file - (c0d70e1) - Sriram Venkatesh
- **(ghostty)** 🐛 add some window padding - (2c730fc) - Sriram Venkatesh
- **(ghostty)** 🐛 fix loading of ghostty config - (2e2f2d8) - Sriram Venkatesh
- **(home-manager)** ✨ enable file backups for smooth activation - (257e462) - Sriram Venkatesh
- **(makefile,homebrew)** 🐛 fix darwin-rebuild paths and disable homebrew - (019a78f) - Sriram Venkatesh
- **(nix)** 🐛 fix configuration issues for proper building - (5876d90) - Sriram Venkatesh
- **(release)** 🐛 remove broken cocogitto config - works better with defaults - (4b9034f) - Sriram Venkatesh
- **(starship)** 🐛 spacing between branch & duration - (3095194) - Sriram Venkatesh
- **(wsl)** 🐛 uname no longer references wsl - (b6f4305) - Sriram Venkatesh
- update plugin hashes and remove redundant plugins - (2a7fabf) - Sriram Venkatesh
- address PR review comments - (78380e8) - Sriram Venkatesh
- resolve Fish PATH initialization issues - (625b543) - Sriram Venkatesh
- 🐛 item updates - (4d6353b) - srizzling
- 🐛 make lsd abbrs work - (64d66eb) - srizzling
- 🐛 asdf is becoming slow? - (b2d1ccf) - srizzling
- 🐛 fuck grc - (ff4684d) - srizzling
- 🐛 migrate from exa to lsd - (2e4227e) - srizzling
- 🐛 goroot - (ca39a50) - srizzling
- 🐛 make dotfiles work on macos - (b94e021) - Sriram Venkatesh
- 🐛 install python versions - (e3a5629) - Sriram Venkatesh
- 🐛 add tool versions symlink - (4904bba) - Sriram Venkatesh
- 🐛 fiiiiiiix - (bcabf25) - Sriram Venkatesh
- 🐛 Replace asdf with fisher plugin - (f966f60) - Sriram Venkatesh
- 🐛 linting - (a3c17dd) - Sriram Venkatesh
- 🐛 remove debug logging - (31dfc31) - Sriram Venkatesh
- 🐛 silverblue setup configuration - (ecfd9d4) - Sriram Venkatesh
#### Continuous Integration
- 👷 release notes more types - (d39d9fa) - Sriram Venkatesh
- 👷 add release management - (06e7966) - Sriram Venkatesh
#### Documentation
- **(readme)** 📝 simplify README to focus on bootstrap, daily usage, tools, and architecture - (0c323ac) - Sriram Venkatesh
- **(readme)** 📝 add release workflow documentation to development guidelines - (49ddcd4) - Sriram Venkatesh
- **(repo)** 📝 update git-emoji functions and commit format documentation - (b658cd6) - Sriram Venkatesh
- **(repo)** 📝 add CLAUDE.md with git-emoji conventions and development guidelines - (ad09af1) - Sriram Venkatesh
- update README with comprehensive Nix setup instructions - (23a8536) - Sriram Venkatesh
- 📝 update readme with bootstrap - (4e7531e) - Sriram Venkatesh
#### Features
- **(aerospace)** ✨ assign ghostty to t workspace - (e3224d5) - Sriram Venkatesh
- **(aerospace)** ✨ add more social applications - (6a8bb26) - Sriram Venkatesh
- **(base)** ✨ Add host-specfic configuration - (62d7dc9) - Sriram Venkatesh
- **(brew)** ✨ Automate and enhance brew management - (58690a7) - Sriram Venkatesh
- **(brew)** ✨ Added cask "libreoffice" - (836d94b) - Sriram Venkatesh
- **(brew)** ✨ Added vscode "davidanson.vscode-markdownlint" - (a455583) - Sriram Venkatesh
- **(brew)** ✨ Update Brewfile - diff --git a/brew/Brewfile b/brew/Brewfile - (5526158) - Sriram Venkatesh
- **(brew,devbox)** ✨ replace brew with devbox where possible - (e1693d6) - Sriram Venkatesh
- **(ci)** ✨ add automated release workflow with GoReleaser - (e8e09a4) - Sriram Venkatesh
- **(fisher)** ✨ add projectdo plugin - (0fea7b8) - srizzling
- **(ghostty)** ✨ introducing ghostty configuration - (925ac1c) - Sriram Venkatesh
- **(git)** ✨ move some global configuration to git - (773ed35) - Sriram Venkatesh
- **(homebrew,home-manager)** ✨ re-enable home-manager and update homebrew apps - (9df7713) - Sriram Venkatesh
- **(migration)** complete phase 1-3 dotfiles migration to Nix - (3303543) - Sriram Venkatesh
- **(nix)** ✨ add nix flakes infrastructure for multi-arch dotfiles - (e5a3ba7) - Sriram Venkatesh
- **(phase1)** ✨ complete homebrew to nix migration with GUI apps and home-manager - (56f1b43) - Sriram Venkatesh
- **(raycast)** ✨ configure raycast as spotlight replacement - (0d9c102) - Sriram Venkatesh
- **(release)** ✨ replace GitHub Actions auto-tagging with Cocogitto manual releases - (115df0a) - Sriram Venkatesh
- **(saml2aws)** ✨ introduce saml2aws - (d6a4f4e) - Sriram Venkatesh
- **(vim)** ✨ add minimal .vimrc for commit msgs - (cecbfeb) - Sriram Venkatesh
- **(vim)** ✨ add minimal .vimrc for commit msgs - (15898c3) - Sriram Venkatesh
- **(vscode)** ✨ sync extentions and vscode settings - (413f1d5) - Sriram Venkatesh
- add Claude Code and Firefox, improve test suite - (afbeccd) - Sriram Venkatesh
- add srizzling/fish-git-emojis plugin - (798b56f) - Sriram Venkatesh
- add comprehensive package configurations - (e45981c) - Sriram Venkatesh
- add Ghostty terminal via brew-nix - (fa0ff3c) - Sriram Venkatesh
- ✨ update starship for azure - (b315f7e) - Sriram Venkatesh
- ✨ add aerospace - (e7863ff) - Sriram Venkatesh
- ✨ Add fixup and autosquash for git - (ac0e4bb) - Sriram Venkatesh
- ✨ Add asdf plugin to fisher - (8d34551) - Sriram Venkatesh
- ✨ generic updates from client laptop - (043f80f) - Sriram Venkatesh
- ✨ sway wofi and alacritty - (32d6a3f) - Sriram Venkatesh
- ✨ sync - (8aad521) - Sriram Venkatesh
- ✨ sylink config files to .config - (22c3c4c) - Sriram Venkatesh
- ✨ manage lang versions with asdf - (8cfd5a5) - Sriram Venkatesh
- ✨ wsl with ubuntu support - (00ce3f7) - Sriram Venkatesh
#### Miscellaneous Chores
- **(brew)** 🧹 add brewfile lock to gitignore - (03c3d83) - Sriram Venkatesh
- **(iterm)** 🧹 remove iterm config - (f983854) - Sriram Venkatesh
- **(release)** 1.2.0 [skip ci] - (28f345c) - semantic-release-bot
- **(release)** 1.1.1 [skip ci] - (a73a701) - semantic-release-bot
- **(release)** 1.1.0 [skip ci] - (c70bcd5) - semantic-release-bot
- **(release)** 1.0.0 [skip ci] - (cbda442) - semantic-release-bot
- **(vscode)** 🧹 sync up vscode - (93c741b) - Sriram Venkatesh
- **(vscode)** 🧹 sync vscode extentions - (8422a6c) - Sriram Venkatesh
- 🧹 linting tools and changes - (4fabfe0) - Sriram Venkatesh
- ⬆ brew update - (6fe7968) - Sriram Venkatesh
- ⬆ brew update - (ab76fdc) - Sriram Venkatesh
- 🧹 brew package update - (6cf9abf) - srizzling
- 🧹 brew packages update - (317ef2b) - srizzling
- 🧹 migrate to lsd - (3d555c5) - srizzling
- 🧹 updated tool versions - (abf9a8b) - Sriram Venkatesh
- ⬆ update local build tools - (612811f) - Sriram Venkatesh
- ⬆ update fisher plugins - (f9ae1c5) - Sriram Venkatesh
- 🧹 change vscode font back to iosevka - (eb9c6c9) - Sriram Venkatesh
#### Refactoring
- **(asdf)** ♻️ Cleanup asdf install - (9790d32) - Sriram Venkatesh
#### Tests
- add Fishtape test infrastructure - (26d872b) - Sriram Venkatesh

- - -

Changelog generated by [cocogitto](https://github.com/cocogitto/cocogitto).