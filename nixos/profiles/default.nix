{ config, lib, pkgs, ... }:
{
  imports = [
    ../../common/profiles/nix
    # nixos/profiles/nix/shell.nix

    ./modules

    ./boot
    ./hardware
    ./locale
    ./network
    ./nix
    ./security
    ./shell
    ./users
    #./desktop
    #./generators
    #./installer
    #./virt

    ./adb.nix
    ./agenix.nix
    ./colmena.nix
    ./motd.nix
    ./nixvim.nix
    ./normalize.nix
    ./ollama.nix
    # ./ollama-ui.nix
    ./sshd.nix
    #./auto-upgrade.nix
    #./specialization.nix
    #./stylix.nix

    #++ (with inputs.srvos.nixosModules; [common mixins-nix-experimental mixins-trusted-nix-caches]) ++ [
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
    #./nix/activation-script.nix
    #./boot
    #./home-manager.nix
    #./users/homed.nix
  ];

  # Mount /etc via overlay filesystem (faster activation)
  system.etc.overlay = {
    enable  = lib.mkForce true;
    mutable = lib.mkDefault true;
  };

  # Enable extra info/metadata for packages
  appstream.enable = lib.mkIf config.services.xserver.enable true;

  # Always load modules: USB controller, NVMe controller, SATA controller, USB gadgets/peripherals
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "ahci" "usbhid" "usb_storage"];

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
