{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (inputs.self + /nixos/profiles/acme.nix)
    # (inputs.self + /nixos/profiles/activitywatch.nix)
    (inputs.self + /nixos/profiles/adb.nix)
    (inputs.self + /nixos/profiles/adblock.nix)
    (inputs.self + /nixos/profiles/agenix.nix)
    (inputs.self + /nixos/profiles/apparmor.nix)
    (inputs.self + /nixos/profiles/appimage.nix)
    (inputs.self + /nixos/profiles/arion.nix)
    # (inputs.self + /nixos/profiles/auditd.nix)
    (inputs.self + /nixos/profiles/auto-upgrade.nix)
    # (inputs.self + /nixos/profiles/avahi.nix)
    (inputs.self + /nixos/profiles/bash.nix)
    (inputs.self + /nixos/profiles/bootspec.nix)
    (inputs.self + /nixos/profiles/cachix-agent.nix)
    # (inputs.self + /nixos/profiles/chromium.nix)
    (inputs.self + /nixos/profiles/colmena.nix)
    (inputs.self + /nixos/profiles/containerd.nix)
    # (inputs.self + /nixos/profiles/cosmic.nix)
    (inputs.self + /nixos/profiles/crio.nix)
    (inputs.self + /nixos/profiles/disko.nix)
    # (inputs.self + /nixos/profiles/displaylink.nix)
    # (inputs.self + /nixos/profiles/dnscrypt-proxy.nix)
    # (inputs.self + /nixos/profiles/docker.nix)
    # (inputs.self + /nixos/profiles/envfs.nix)
    (inputs.self + /nixos/profiles/facter.nix)
    (inputs.self + /nixos/profiles/firewall.nix)
    (inputs.self + /nixos/profiles/fish.nix)
    # (inputs.self + /nixos/profiles/flake-registry.nix)
    # (inputs.self + /nixos/profiles/flatpak.nix)
    # (inputs.self + /nixos/profiles/fprintd.nix)
    # (inputs.self + /nixos/profiles/fs-bcachefs.nix)
    (inputs.self + /nixos/profiles/fs-btrfs.nix)
    (inputs.self + /nixos/profiles/fs-lvm2.nix)
    # (inputs.self + /nixos/profiles/fs-mdadm.nix)
    (inputs.self + /nixos/profiles/fs-ntfs.nix)
    # (inputs.self + /nixos/profiles/fs-zfs.nix)
    (inputs.self + /nixos/profiles/fwupd.nix)
    (inputs.self + /nixos/profiles/fzf.nix)
    # (inputs.self + /nixos/profiles/gdm.nix)
    (inputs.self + /nixos/profiles/generators)
    # (inputs.self + /nixos/profiles/gtk.nix)
    (inputs.self + /nixos/profiles/hardware)
    # (inputs.self + /nixos/profiles/hercules-ci.nix)
    # (inputs.self + /nixos/profiles/hibernation.nix)
    # (inputs.self + /nixos/profiles/hidpi.nix)
    (inputs.self + /nixos/profiles/home-manager.nix)
    (inputs.self + /nixos/profiles/hostapd.nix)
    # (inputs.self + /nixos/profiles/impermanence.nix)
    # (inputs.self + /nixos/profiles/installer.nix)
    # (inputs.self + /nixos/profiles/iscsi-initiator.nix)
    # (inputs.self + /nixos/profiles/kvm.nix)
    # (inputs.self + /nixos/profiles/lanzaboote.nix)
    # (inputs.self + /nixos/profiles/libreoffice.nix)
    # (inputs.self + /nixos/profiles/libvirt.nix)
    (inputs.self + /nixos/profiles/locale-est.nix)
    # (inputs.self + /nixos/profiles/lxc.nix)
    # (inputs.self + /nixos/profiles/lxd.nix)
    # (inputs.self + /nixos/profiles/lxd-image-server.nix)
    # (inputs.self + /nixos/profiles/memtest86.nix)
    # (inputs.self + /nixos/profiles/microvm.nix)
    # (inputs.self + /nixos/profiles/microvm-guest.nix)
    # (inputs.self + /nixos/profiles/monado.nix)
    (inputs.self + /nixos/profiles/motd.nix)
    # (inputs.self + /nixos/profiles/netbootxyz.nix)
    (inputs.self + /nixos/profiles/network) # ./network/{iscsi-initiator,netboot,pixieboot}.nix
    (inputs.self + /nixos/profiles/networkmanager.nix)
    (inputs.self + /nixos/profiles/nix)
    (inputs.self + /nixos/profiles/nixvim.nix)
    (inputs.self + /nixos/profiles/normalize.nix)
    (inputs.self + /nixos/profiles/nushell.nix)
    # (inputs.self + /nixos/profiles/nvidia.nix)
    (inputs.self + /nixos/profiles/nvme.nix)
    (inputs.self + /nixos/profiles/ollama.nix)
    # (inputs.self + /nixos/profiles/ollama-ui.nix)
    (inputs.self + /nixos/profiles/plymouth.nix)
    # (inputs.self + /nixos/profiles/podman.nix)
    # (inputs.self + /nixos/profiles/polkit.nix)
    # (inputs.self + /nixos/profiles/printing.nix)
    # (inputs.self + /nixos/profiles/qemu.nix)
    # (inputs.self + /nixos/profiles/qemu-web.nix)
    # (inputs.self + /nixos/profiles/qt.nix)
    # (inputs.self + /nixos/profiles/quiet-boot.nix)
    (inputs.self + /nixos/profiles/resolvconf.nix)
    # (inputs.self + /nixos/profiles/rxe.nix)
    (inputs.self + /nixos/profiles/shell-aliases.nix)
    # (inputs.self + /nixos/profiles/sits.nix)
    # (inputs.self + /nixos/profiles/slippi.nix)
    # (inputs.self + /nixos/profiles/snowflake.nix)
    (inputs.self + /nixos/profiles/sops.nix)
    # (inputs.self + /nixos/profiles/specialization.nix)
    (inputs.self + /nixos/profiles/sshd.nix)
    # (inputs.self + /nixos/profiles/sshfs.nix)
    # (inputs.self + /nixos/profiles/steam.nix)
    # (inputs.self + /nixos/profiles/stylix.nix)
    (inputs.self + /nixos/profiles/sudo-rs.nix)
    # (inputs.self + /nixos/profiles/sudo.nix)
    (inputs.self + /nixos/profiles/systemd-boot.nix)
    # (inputs.self + /nixos/profiles/systemd-debug.nix)
    # (inputs.self + /nixos/profiles/systemd-emergency.nix)
    # (inputs.self + /nixos/profiles/systemd-homed.nix)
    (inputs.self + /nixos/profiles/systemd-initrd.nix)
    # (inputs.self + /nixos/profiles/systemd-networkd.nix)
    # (inputs.self + /nixos/profiles/systemd-repart.nix)
    # (inputs.self + /nixos/profiles/systemd-resolved.nix)
    (inputs.self + /nixos/profiles/tailscale.nix)
    # (inputs.self + /nixos/profiles/tcpcrypt.nix)
    (inputs.self + /nixos/profiles/thunderbolt.nix)
    # (inputs.self + /nixos/profiles/tlp.nix)
    # (inputs.self + /nixos/profiles/tor.nix)
    # (inputs.self + /nixos/profiles/touchscreen.nix)
    # (inputs.self + /nixos/profiles/tpm2.nix)
    # (inputs.self + /nixos/profiles/ucarp.nix)
    (inputs.self + /nixos/profiles/usb.nix)
    (inputs.self + /nixos/profiles/user-primary.nix)
    # (inputs.self + /nixos/profiles/virt.nix)
    # (inputs.self + /nixos/profiles/vm-guest-windows.nix)
    # (inputs.self + /nixos/profiles/vm-host.nix)
    # (inputs.self + /nixos/profiles/vm.nix)
    # (inputs.self + /nixos/profiles/waydroid.nix)
    # (inputs.self + /nixos/profiles/wayland.nix)
    # (inputs.self + /nixos/profiles/wgautomesh.nix)
    # (inputs.self + /nixos/profiles/wine.nix)
    (inputs.self + /nixos/profiles/wireguard.nix)
    # (inputs.self + /nixos/profiles/xserver.nix)
    (inputs.self + /nixos/profiles/zsh.nix)

    #++ (with inputs.srvos.nixosModules; [common mixins-nix-experimental mixins-trusted-nix-caches]) ++ [
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
    # (inputs.self + /nixos/profiles/nix/activation-script.nix)

    # https://github.com/polygon/scalpel
    # scalpel.nixosModules.scalpel

    # https://github.com/nix-community/srvos
    # srvos.nixosModules.common #                  # desktop, server,   mixins-terminfo,     mixins-tracing,
    # srvos.nixosModules.mixins-nix-experimental # NOTE: Broken setting: experimental-features = ["configurable-impure-env"]
    # mixins-cloud-init, mixins-systemd-boot, mixins-telegraf
    inputs.srvos.nixosModules.mixins-trusted-nix-caches # roles-github-actions-runner, roles-nix-remote-builder
  ];

  # Mount /etc via overlay filesystem (faster activation)
  # system.etc.overlay = {
  #   enable  = lib.mkForce true;
  #   mutable = lib.mkForce true;
  # };
  # users.mutableUsers = lib.mkForce false;

  # Enable extra info/metadata for packages
  appstream.enable = lib.mkIf config.services.xserver.enable true;

  # Always load modules: USB controller, NVMe controller, SATA controller, USB gadgets/peripherals
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "ahci" "usbhid" "usb_storage"];
  boot.initrd.includeDefaultModules = true;
  # boot.initrd.systemd.enable = true;
  boot.hardwareScan = true;
  boot.loader = {
    timeout = lib.mkDefault 6; # Sec until default entry boots.  `null`=wait-for-input
    # [nix-community/srvos](https://github.com/nix-community/srvos/blob/main/nixos/mixins/systemd-boot.nix) recommend enable during install only

    # Where to mount the EFI system partition
    #  TODO: Follow Discoverable Partitions Spec:
    #    https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
    #    - TODO: `XBOOTLDR` / `ESP` splitting?
    #    - TODO: Rewrite to `/efi`, `/boot`, or `/boot/efi`?
    #  NOTE: Set to "/boot/efi" in `nixos/hosts/fw/configuration.nix`
    #  Default: "/boot"
    efi.efiSysMountPoint = lib.mkDefault "/boot"; # "/boot/efi";
    efi.canTouchEfiVariables = lib.mkDefault true; # Whether allow install process to modify EFI boot vars
  };

  # Set host ID to first 8 characters of /etc/machine-id
  # TODO: Fix infinite recursion error
  # networking.hostId = lib.substring 0 8 config.environment.etc.machine-id.text;
  networking.domain = "lehman.run";

  # Unix ODBC drivers to register in /etc/odbcinst.ini
  environment.unixODBCDrivers = [pkgs.unixODBCDrivers.sqlite pkgs.unixODBCDrivers.psql];
  environment.systemPackages = [
    pkgs.systemctl-tui
    # Package to get CLI clients to connect to ODBC databases.
    pkgs.unixODBC

    # TODO: Move most of these to home-manager profile (default user?)
    pkgs.bat
    pkgs.eza
    pkgs.gcc
    pkgs.lsd
    pkgs.tealdeer
    pkgs.gnumake
    pkgs.lynis
  ];

  # TODO: Find nix-related program from old config that was better
  # - manix, comma ?
  programs.command-not-found.enable = lib.mkDefault false;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };
  programs.less = {
    enable = true;
    lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
  };
  programs.traceroute.enable = true;
  programs.gnupg = {
    dirmngr.enable = true;
    agent.enableExtraSocket = true;
    agent.enableBrowserSocket = true;
  };

  # Symlink our repo to /etc/nixos, for shorter nixos-rebuild command
  environment.etc."nixos".source = inputs.self.outPath;

  # `at` daemon for scheduling commands
  services.atd.enable = true;

  # --- lsb-release / os-release ---
  # environment.etc = let
  #   needsEscaping = s: null != builtins.match "[a-zA-Z0-9]+" s;
  #   escapeIfNeccessary = s: if needsEscaping s then s else ''"${lib.escape ["$" ''"'' "\\" "`"] s}"'';
  #   attrsToText = attrs: lib.concatStringsSep "\n" (lib.mapAttrsToList (n: v: "${n}=${escapeIfNeccessary (toString v)}") attrs) + "\n";
  #   lsb-rel = {
  #     LSB_VERSION = "${config.system.nixos.release} (${config.system.nixos.codeName})";
  #     DISTRIB_ID = "nixos";
  #     DISTRIB_RELEASE = config.system.nixos.release;
  #     DISTRIB_CODENAME = lib.toLower config.system.nixos.codeName;
  #     DISTRIB_DESCRIPTION = "LehmanatorOS";
  #   };
  #   os-rel = {
  #     NAME = "NixOS";
  #     ID = "nixos";
  #     VERSION = "${config.system.nixos.release} (${config.system.nixos.codeName})";
  #     VERSION_CODENAME = lib.toLower config.system.nixos.codeName;
  #     VERSION_ID = config.system.nixos.release;
  #     VARIANT_ID = lib.mkIf (config.system.nixos.variant_id != null) config.system.nixos.variant_id;
  #     BUILD_ID = config.system.nixos.version;
  #     PRETTY_NAME = "LehmanatorOS";
  #     LOGO = "nix-snowflake";
  #     HOME_URL = "https://nixos.org/";
  #     DOCUMENTATION_URL = "https://nixos.org/learn.html";
  #     SUPPORT_URL = "https://nixos.org/community.html";
  #     BUG_REPORT_URL = "https://github.com/Lehmanator/nix-configs/issues";
  #   };
  #   initrd-rel = (lib.removeAttrs os-rel ["BUILD_ID"]) // { PRETTY_NAME = "${os-rel.PRETTY_NAME} (initrd)"; };
  # in {
  #   lsb-release.text = attrsToText lsb-rel;
  #   os-release.text = attrsToText os-rel;
  # };

  # --- Merged Libs from Flake Inputs ---
  # Merge libs from flake inputs
  # lib = let
  #   nixpkgs-variants = ["nixpkgs" "nixpkgs-darwin" "nixpkgs-master" "nixpkgs-stable" "nixpkgs-staging" "nixpkgs-staging-next" "nixpkgs-unstable" "nixos" "nixos-stable" "nixos-unstable" "stable" "unstable"];
  #   inputsWithLibs = lib.filterAttrs (n: v:
  #       # Remove nixpkgs variants
  #       (! (builtins.elem n nixpkgs-variants)) &&
  #       # Remove inputs without outputs.lib attrset
  #       ((builtins.hasAttr "lib" v) && (builtins.isAttrs v.lib)) &&
  #       # Remove empty libs
  #       (v.lib != {})
  #     ) inputs;
  #   # Filter out items that arent functions or attrsets
  #   filterLibs = lib.filterAttrs (n1: v1: (builtins.isFunction v1) || (builtins.isAttrs v1));
  #   allLibs = builtins.mapAttrs (n: v:
  #     # if (builtins.attrNames v.lib == [n] && (builtins.isFunction v.lib.${n}))
  #     # then v.lib.${n}
  #     # else
  #       filterLibs (
  #         # Desystemize libs
  #         if builtins.hasAttr pkgs.system v.lib
  #         then v.lib.${pkgs.system}
  #         else if (builtins.attrNames v.lib == [n] && (builtins.isAttrs v.lib.${n})) # || builtins.isFunction v.lib.${n}))
  #         then v.lib.${n}
  #         # Hoist attrsets with the same name as input
  #         # else if
  #         #   (builtins.length (builtins.attrNames v.lib) == 1)
  #         #   && (builtins.elem n (builtins.attrNames v.lib))
  #         # then v.lib.${n}
  #         else v.lib
  #       ))
  #   inputsWithLibs;
  #   # (builtins.hasAttr n v.lib && (builtins.isAttrs v.lib.${n} || builtins.isFunction v.lib.${n}))
  #   # then v.lib.${n}
  #   # else v.lib
  #   # )
  #   # )
  #   # hasLibs;
  # in allLibs;
  #
  # {
  #   bird = inputs.bird.lib; #.overlay;
  #   disko = inputs.disko.lib;
  #   hm = inputs.home.lib;
  #   colmena = inputs.colmena.lib;
  # };
}
