{ inputs, config, lib, pkgs, user, ... }: {
  home = {
    packages = [ pkgs.pmbootstrap ];
    shellAliases = {
      pmb = lib.getExe pkgs.pmbootstrap;
      pmbI = "pmb init";
      pmbi = "pmb install --fde --add unl0kr";
      pmbc = "pmb config";
      pmbf =
        "fastboot erase dtbo && pmb flasher flash_rootfs --partition=userdata && pmb flasher flash_kernel";
      pmbp = "pmb pull";
      pmbu = "pmb update";
      pmbv = "pmb --version";
    };
    file = {
      flash-pmos = {
        enable = true;
        executable = true;
        #onChange = "";
        target = ".local/bin/flash-pmos";
        text = ''
          #!/usr/bin/env bash
          pmbootstrap install --fde --add unl0kr && \
          fastboot erase dtbo && sleep 3 && \
          pmbootstrap flasher flash_rootfs --partition=userdata && sleep 5 && \
          pmbootstrap flasher flash_kernel && sleep 5 && \
          fastboot reboot bootloader
        '';
      };
      update-pmos = {
        executable = true;
        target = ".local/bin/update-pmos";
        text = ''
          #!/usr/bin/env bash
          pmbootstrap pull && \
          pmbootstrap aportupgrade --all && \
          pmbootstrap index  # && \
        '';
      };
    };
  };

  # TODO: Convert to Nix, use lib to write as TOML
  # TODO: Merge with device configs, fajita0, fajita1, smtaba8
  # TODO: Set keymap
  # TODO: Set nonfree_firmware, nonfree_userland based on nixpkgs config.allow-unfree?
  # https://wiki.postmarketos.org/wiki/Waydroid
  #xdg.configFile = {
  #  "pmbootstrap.cfg".text =
  #    let
  #      pm-packages = [
  #        "abootimg" "abootimg-doc"
  #        "alpine-repo-tools" "alpine-repo-tools-zsh-completion"
  #        "android-tools" "android-tools-zsh-completion"
  #        "apk-tools" "apk-tools-zsh-completion"
  #        "bat" "bat-zsh-completion"
  #        "bootchart2"
  #        "devicepkg-utils"
  #        "dino"
  #        "dtbtool"
  #        "dnsmasq"
  #        "epiphany"
  #        "extract-dtb"
  #        "eza"
  #        "fd" "fd-zsh-completion"
  #        "flatpak" "flatpak-bash-completion" "flatpak-zsh-completion" "flatpak-builder" "flatpak-builder-doc" "flatpak-xdg-utils" "gnome-software-plugin-flatpak"
  #        "fractal"
  #        "fzf" "fzf-zsh-plugin"
  #        "git" "git-zsh-completion" "github-cli" "github-cli-zsh-completion"
  #        "gnome-maps"
  #        "gnome-weather"
  #        "gpg-tui" "gpg-tui-zsh-completion"
  #        "gst-plugins-good-gtk"
  #        "handlr" "handlr-zsh-completion"
  #        "helm" "helm-zsh-completion"
  #        "kubectl" "kubectl-zsh-completion" "k9s" "k9s-zsh-completion"
  #        "ldpath"
  #        "lsd"
  #        "make-dynpart-mappings"
  #        "mobile-config-firefox"
  #        "msm-firmware-loader"
  #        "msm-fb-refresher"
  #        "navi" "navi-zsh-completion"
  #        "neovim" "neovim-doc" "fzf-neovim" "py3-pynvim"
  #        "nix" "nix-bash-completion" "nix-doc" "nix-manual" "nix-openrc" "nix-zsh-completion" "tree-sitter-nix" "tree-sitter-nix-doc"
  #        "osk-sdl" "osk-sdl-doc"
  #        "osmin"
  #        "pass" "pass-zsh-completion"
  #        "pd-mapper"
  #        "pmbootstrap"
  #        "postmarketos-artwork-wallpapers-extra"
  #        "postmarketos-installkernel" "postmarketos-update-kernel" "postmarketos-release-upgrade"
  #        #"postmarketos-ondev" "postmarketos-ondev-openrc"
  #        "procs" "procs-zsh-completion"
  #        "progress" "progress-zsh-completion"
  #        "qcom-diag"
  #        "rage" "rage-zsh-completion"
  #        "rbw" "rbw-zsh-completion"
  #        "reboot-mode"
  #        "ripgrep" "ripgrep-zsh-completion"
  #        "rsync" "rsync-zsh-completion"
  #        "seahorse"
  #        "starship" "starship-zsh-completion" "starship-zsh-plugin"
  #        "systemd-boot"
  #        "tealdeer" "tealdeer-zsh-completion"
  #        "tmux" "tmux-zsh-completion"
  #        "topgrade" "topgrade-zsh-completion"
  #        "udisks2" "udisks2-zsh-completion"
  #        "udiskie" "udiskie-zsh-completion"
  #        "ukify"
  #        "unixbench"
  #        "unl0kr"
  #        "unl0kr-doc"
  #        "util-linux-misc"
  #        "vim"
  #        "waydroid" "waydroid-nftables" "iptables" "iptables-legacy"
  #        "wireguard-tools-wg-quick"
  #        "wl-clipboard" "wl-clipboard-zsh-completion"
  #        "xdg-desktop-portal-gnome" "xdg-ninja" "xdg-user-dirs" "xdg-user-dirs-gtk" "xdg-utils" "xdg-utils-doc"
  #        "yt-dlp" "yt-dlp-zsh-completion"
  #        "zsh" "zsh-autosuggestions" "zsh-calendar" "zsh-completions" "zsh-doc" "zsh-fast-syntax-highlighting" "zsh-fzf-tab" "zsh-hitdb" "zsh-history-substring-search" "zsh-manydots-magic" "zsh-pcre" "zsh-shift-select" "zsh-theme-powerlevel10k" "zsh-vcs" "zsh-zftp" #"zsh-histdb-skim"
  #      ];
  #      system-cfg = ''
  #        aports = /home/${user}/.local/var/pmbootstrap/cache_git/pmaports
  #        nonfree_firmware = ${config.hardware.enableRedistributableFirmware}
  #        nonfree_userland = ${config.nixpkgs.config.allow-unfree}
  #        user = ${user}
  #        work = /home/${user}/.local/var/pmbootstrap
  #      '';
  #      device-fajita0 = ''
  #        device = oneplus-fajita
  #        extra_space = 102400
  #        hostname = fajita0
  #        ui = gnome-mobile
  #        ui_extras = True
  #        kernel = stable
  #        nonfree_firmware = True
  #        nonfree_userland = True
  #      '';
  #    in
  #    ''
  #      [pmbootstrap]
  #      ${device-fajita0}
  #      aports = /home/${user}/.local/var/pmbootstrap/cache_git/pmaports
  #      boot_size = 256
  #      build_pkgs_on_install = True
  #      ccache_size = 50
  #      #extra_packages = dino,epiphany,flatpak,fractal,gnome-maps,gnome-weather,gnome-software-plugin-flatpak,gst-plugins-good-gtk,osmin,,seahorse,vim,waydroid,wireguard-tools-wg-quick
  #      extra_packages = dino,epiphany,flatpak,fractal,gnome-maps,gnome-weather,gst-plugins-good-gtk,osmin,seahorse,vim,waydroid,wireguard-tools-wg-quick,bat,bat-zsh-completion,dnsmasq,eza,fd,fd-zsh-completion,flatpak-zsh-completion,flatpak-builder,flatpak-builder-doc,flatpak-xdg-utils,gnome-software-plugin-flatpak,fzf,fzf-zsh-plugin,git,git-zsh-completion,github-cli,github-cli-zsh-completion,gpg-tui,gpg-tui-zsh-completion,handlr,handlr-zsh-completion,helm,helm-zsh-completion,kubectl,kubectl-zsh-completion,k9s,k9s-zsh-completion,lsd,navi,neovim,neovim-doc,fzf-neovim,py3-pynvim,nix,nix-bash-completion,nix-doc,nix-manual,nix-openrc,nix-zsh-completion,tree-sitter-nix,tree-sitter-nix-doc,pass,pass-zsh-completion,procs,procs-zsh-completion,progress,progress-zsh-completion,rage,rage-zsh-completion,rbw,rbw-zsh-completion,reboot-mode,ripgrep,ripgrep-zsh-completion,rsync,rsync-zsh-completion,starship,starship-zsh-completion,starship-zsh-plugin,tealdeer,tealdeer-zsh-completion,tmux,tmux-zsh-completion,topgrade,topgrade-zsh-completion,udisks2,udisks2-zsh-completion,udiskie,udiskie-zsh-completion,unixbench,unl0kr,unl0kr-doc,util-linux-misc,waydroid-nftables,wl-clipboard,wl-clipboard-zsh-completion,xdg-desktop-portal-gnome,xdg-ninja,xdg-user-dirs,xdg-user-dirs-gtk,xdg-utils,xdg-utils-doc,yt-dlp,yt-dlp-zsh-completion,zsh,zsh-autosuggestions,zsh-completions,zsh-doc,zsh-fast-syntax-highlighting,zsh-fzf-tab,zsh-histdb,zsh-history-substring-search,zsh-manydots-magic,zsh-pcre,zsh-shift-select,zsh-vcs
  #      extra_packages = dino,epiphany,flatpak,fractal,gnome-maps,gnome-weather,gst-plugins-good-gtk,osmin,seahorse,waydroid,wireguard-tools-wg-quick,bat,dnsmasq,eza,fd,flatpak-zsh-completion,flatpak-builder,flatpak-xdg-utils,gnome-software-plugin-flatpak,fzf,git,git-zsh-completion,github-cli,github-cli-zsh-completion,helm,helm-zsh-completion,kubectl,kubectl-zsh-completion,k9s,k9s-zsh-completion,lsd,neovim,nix,nix-openrc,nix-zsh-completion,tree-sitter-nix,tree-sitter-nix-doc,ripgrep,ripgrep-zsh-completion,starship,starship-zsh-completion,starship-zsh-plugin,tealdeer,tealdeer-zsh-completion,topgrade,topgrade-zsh-completion,unl0kr,waydroid-nftables,wl-clipboard,wl-clipboard-zsh-completion,xdg-desktop-portal-gnome,xdg-user-dirs,xdg-utils,zsh,zsh-autosuggestions,zsh-completions,zsh-fast-syntax-highlighting,zsh-fzf-tab,zsh-histdb,zsh-history-substring-search,zsh-manydots-magic,zsh-pcre
  #      is_default_channel = False
  #      jobs = 17
  #      keymap =
  #      locale = C.UTF-8
  #      mirror_alpine = http://dl-cdn.alpinelinux.org/alpine/
  #      mirros_postmarketos = http://mirror.postmarketos.org/postmarketos/
  #      qemu_redir_stdio = False
  #      ssh_keys = True
  #      ssh_keys_glob = ~/.ssh/id_*.pub
  #      sudo_timer = False
  #      timezone = EST
  #      user = ${user}
  #      work = /home/${user}/.local/var/pmbootstrap
  #
  #      [providers]
  #
  #    '';
  #  "pmaports.cfg".text = ''
  #    # Reference: https://postmarketos.org/pmaports.cfg
  #    [pmaports]
  #    channel = edge
  #    install_user_groups = audio,flatpak,netdev,plugdev,video,wheel
  #    pmbootstrap_min_version = 2.0.0
  #    supported_firewall = nftables
  #    supported_root_filesystem = f2fs
  #    #supported_root_filesystem = ext4
  #  '';
  #};

  #home.file.".local/bin/fajita0-setup.sh".text = ''
  #  #!/usr/bin/env ash
  #  sudo apk add waydroid waydroid-nftables iptables-legacy
  #  sudo rc-update add cgroups default
  #  sudo rc-service cgroups start
  #  sudo apk add iptables dnsmasq
  #  sudo rc-service waydroid-container start
  #  sudo rc-update add waydroid-container default
  #  waydroid session start
  #  waydroid status
  #  waydroid app list
  #
  #  sudo apk add flatpak
  #  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #  flatpak install flathub \
  #    org.nanuc.Axolotl \
  #    org.gnome.Nautilus \
  #    org.gnome.NautilusPreviewer \
  #'';

  # TODO: Create pmbootstrap GitHub personal access token.
  # TODO: Configure pmbootstrap to use GitHub personal access token.
  #sops.secrets.github-token-pmbootstrap = {};
}
