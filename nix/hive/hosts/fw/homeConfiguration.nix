{ inputs, cell, super, }:
let
  inherit (super.bee) pkgs;
  modules = with inputs; [
   # inputs.omnibus.src.hive.beeModule
    # emanote.homeManagerModule.default
    # sops-nix.homeManagerModules.sops
    nix-flatpak.homeManagerModules.nix-flatpak
  ];
  profiles = with cell.homeProfiles; [
    abook
    app-bitwarden
    app-chromium
    app-discord
    app-facebook
    gnome-app-amberol
    gnome-app-calculator
    gnome-app-cozy
    gnome-app-decibels
    gnome-app-dino
    gnome-app-gradience
    gnome-app-lemoa
    gnome-app-lemonade
    gnome-app-loupe
    gnome-app-tuba
    gnome-app-valent
    gnome-app-vaults
    app-libreoffice
    app-matrix
    app-pidgin
    app-signal
    app-sms
    app-telegram
    app-torbrowser
    app-twitch
    apps-base
    apps-gnome-base
    apps-gnome-chat
    apps-gnome-dbus
    apps-gnome-developer
    apps-gnome-extras
    apps-gnome-finance
    apps-gnome-mobile
    apps-gnome-multimedia
    apps-gnome-productive
    apps-gnome-reading
    apps-gnome-rss
    apps-gnome-security
    apps-gnome-social
    apps-gnome-translate
    apps-microsoft
    audio
    bat
    cachix-agent
    chess
    device-android
    device-asteroidos
    device-fajita
    device-google
    device-nintendo-switch
    device-oneplus
    device-pine64
    device-pinetime
    device-postmarketos
    device-riscv
    device-samsung
    device-sawfish
    direnv
    distrobox
    documentation
    dolphin
    editorconfig
    # emanote
    eza
    fetchers
    flatpak
    fonts
    fzf
    # game-slippi
    game-spacecadetpinball
    gaming-chat
    gaming-clips
    # git/ aliases base diff fzf gh gitui hooks ignore mr sync tui
    gnome-adwaita-themes
    gnome-emojis
    gnome-extension-ags
    gnome-extension-ddterm
    gnome-extension-forge
    # gnome-extension-materialyoucolors
    gnome-extension-searchprovider-browsertabs
    gnome-extension-tophat
    gnome-keyring
    gnome-shell
    gpg
    gtk
    helix
    helm
    ibus
    k9s
    lang-nodejs
    lang-python
    lang-rust
    ls
    lsd
    media
    mobile
    myrepos
    navi
    neovim
    nextcloud
    nushell
    # ollama-aichat
    # ollama-smartcat
    ollama
    playerctld
    pls
    polybar
    readline
    recoll
    retroarch
    ripgrep
    rofi
    role-admin-activedirectory
    role-admin-asterisk
    role-admin-aws
    role-admin-azure
    role-admin-containers
    role-admin-firewall
    role-admin-kubernetes
    role-admin-redis
    role-admin-samba
    role-admin-sip
    role-admin-sysadmin
    role-admin-virtualmachines
    # role-admin-windows/ all compat default remote virt
    role-creator-animator
    role-creator-images
    role-creator-music
    role-creator-streamer
    role-creator-video
    # role-developer-android
    role-developer
    role-office-pdf
    role-security-osint
    role-security-pentest
    role-student
    rust-utils
    ryujinx
    secureboot-notify
    shell-aliases
    shell-base
    shell-colors
    social-dl
    social-sleuth
    # sops
    # specialisations
    ssh
    starship
    # stylix
    sync
    # test-host-environment
    tmux
    topgrade
    touchpad
    udiskie
    vm
    vscode
    wayland
    webscraper
    xdg
    yubikey
    yuzu

    # test
  ];
in
{
  inherit (super) bee;
  # sops.defaultSopsFile = inputs.self + /nix/hive/userProfiles/sam/secrets/default.yaml;
  # services.openssh.enable = true;
  imports = pkgs.lib.flatten
  # [
  modules ++ [
    # { imports = modules; }
    { _module.args = super.specialArgs; }
    ({config, ...}: { 
      imports = profiles;
      home = rec {
        inherit (super.meta) stateVersion;
        # username = "sam";
        homeDirectory = "/home/${config.home.username}";
      };
    })
    # ({config, ...}: {
    #    sops = {
    #       defaultSopsFile = inputs.self + /nix/hive/userProfiles/sam/secrets/default.yaml;
    #       age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    #    };
    # })
    # { imports = modules; }
  ];
  # ] ++ modules;
  # ] ++ profiles;
}
