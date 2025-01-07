{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    (inputs.self + /nixos/profiles/adb.nix)
    (inputs.self + /nixos/profiles/agenix.nix)
    (inputs.self + /nixos/profiles/apparmor.nix)
    (inputs.self + /nixos/profiles/arion.nix)
    (inputs.self + /nixos/profiles/auto-upgrade.nix)
    (inputs.self + /nixos/profiles/bootspec.nix)
    (inputs.self + /nixos/profiles/cachix-agent.nix)
    (inputs.self + /nixos/profiles/colmena.nix)
    (inputs.self + /nixos/profiles/fs-btrfs.nix)
    (inputs.self + /nixos/profiles/fs-ntfs.nix)
    (inputs.self + /nixos/profiles/fwupd.nix)
    (inputs.self + /nixos/profiles/generators)
    (inputs.self + /nixos/profiles/hardware)
    # (inputs.self + /nixos/profiles/hibernation.nix)
    (inputs.self + /nixos/profiles/home-manager.nix)
    (inputs.self + /nixos/profiles/locale)
    (inputs.self + /nixos/profiles/motd.nix)
    (inputs.self + /nixos/profiles/network)           # ./network/{iscsi-initiator,netboot,pixieboot}.nix
    (inputs.self + /nixos/profiles/nix)
    (inputs.self + /nixos/profiles/nixvim.nix)
    (inputs.self + /nixos/profiles/normalize.nix)
    (inputs.self + /nixos/profiles/nvme.nix)
    (inputs.self + /nixos/profiles/plymouth.nix)
    (inputs.self + /nixos/profiles/ollama.nix)
    # (inputs.self + /nixos/profiles/ollama-ui.nix)
    (inputs.self + /nixos/profiles/shell)
    (inputs.self + /nixos/profiles/sshd.nix)
    (inputs.self + /nixos/profiles/sops.nix)
    # (inputs.self + /nixos/profiles/specialization.nix)
    # (inputs.self + /nixos/profiles/stylix.nix)
    (inputs.self + /nixos/profiles/sudo-rs.nix)
    (inputs.self + /nixos/profiles/systemd-boot.nix)
    (inputs.self + /nixos/profiles/systemd-initrd.nix)
    # (inputs.self + /nixos/profiles/systemd-debug.nix)
    # (inputs.self + /nixos/profiles/systemd-emergency.nix)
    # (inputs.self + /nixos/profiles/systemd-repart.nix)
    (inputs.self + /nixos/profiles/thunderbolt.nix)
    (inputs.self + /nixos/profiles/usb.nix)
    (inputs.self + /nixos/profiles/user-primary.nix)

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
    
    #./fs/layouts         # ./fs/layouts/xbootldr.nix
  ];

  # Mount /etc via overlay filesystem (faster activation)
  system.etc.overlay = {
    enable  = lib.mkForce true;
    mutable = lib.mkForce true;
  };

  # Enable extra info/metadata for packages
  appstream.enable = lib.mkIf config.services.xserver.enable true;

  # Always load modules: USB controller, NVMe controller, SATA controller, USB gadgets/peripherals
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "ahci" "usbhid" "usb_storage"];
  boot.initrd.includeDefaultModules = true;
  boot.hardwareScan = true;
  boot.loader = {
    timeout = lib.mkDefault 6;  # Sec until default entry boots.  `null`=wait-for-input
    # [nix-community/srvos](https://github.com/nix-community/srvos/blob/main/nixos/mixins/systemd-boot.nix) recommend enable during install only

    # Where to mount the EFI system partition
    #  TODO: Follow Discoverable Partitions Spec: 
    #    https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
    #    - TODO: `XBOOTLDR` / `ESP` splitting?
    #    - TODO: Rewrite to `/efi`, `/boot`, or `/boot/efi`?
    #  NOTE: Set to "/boot/efi" in `nixos/hosts/fw/configuration.nix`
    #  Default: "/boot"
    efi.efiSysMountPoint = lib.mkDefault "/boot"; #"/boot/efi";
    efi.canTouchEfiVariables = lib.mkDefault true;  # Whether allow install process to modify EFI boot vars
  };

  environment.systemPackages = [pkgs.systemctl-tui];

  #environment.etc = let
  #  needsEscaping = s: null != builtins.match "[a-zA-Z0-9]+" s;
  #  escapeIfNeccessary = s:
  #    if needsEscaping s
  #    then s
  #    else ''"${lib.escape ["$" ''"'' "\\" "`"] s}"'';
  #  attrsToText = attrs:
  #    lib.concatStringsSep "\n"
  #    (lib.mapAttrsToList (n: v: "${n}=${escapeIfNeccessary (toString v)}")
  #      attrs)
  #    + "\n";
  #  lsb-rel = {
  #    LSB_VERSION = "${config.system.nixos.release} (${config.system.nixos.codeName})";
  #    DISTRIB_ID = "nixos";
  #    DISTRIB_RELEASE = config.system.nixos.release;
  #    DISTRIB_CODENAME = lib.toLower config.system.nixos.codeName;
  #    DISTRIB_DESCRIPTION = "LehmanatorOS";
  #  };
  #  os-rel = {
  #    NAME = "NixOS";
  #    ID = "nixos";
  #    VERSION = "${config.system.nixos.release} (${config.system.nixos.codeName})";
  #    VERSION_CODENAME = lib.toLower config.system.nixos.codeName;
  #    VERSION_ID = config.system.nixos.release;
  #    VARIANT_ID =
  #      lib.mkIf (config.system.nixos.variant_id != null)
  #      config.system.nixos.variant_id;
  #    BUILD_ID = config.system.nixos.version;
  #    PRETTY_NAME = "LehmanatorOS";
  #    LOGO = "nix-snowflake";
  #    HOME_URL = "https://nixos.org/";
  #    DOCUMENTATION_URL = "https://nixos.org/learn.html";
  #    SUPPORT_URL = "https://nixos.org/community.html";
  #    BUG_REPORT_URL = "https://github.com/Lehmanator/nix-configs/issues";
  #  };
  #  initrd-rel =
  #    (lib.removeAttrs os-rel ["BUILD_ID"])
  #    // {
  #      PRETTY_NAME = "${os-rel.PRETTY_NAME} (initrd)";
  #    };
  #in {
  #  lsb-release.text = attrsToText lsb-rel;
  #  os-release.text = attrsToText os-rel;
  #};
}
