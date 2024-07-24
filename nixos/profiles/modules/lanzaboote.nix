{ inputs, config, lib, pkgs, user, ... }:
#
# https://github.com/nix-community/lanzaboote
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
# https://wiki.archlinux.org/title/Secure_Boot#Booting_an_installation_medium
#
# TODO: impermanence: persist /etc/secureboot
# TODO: Learn about `lib.extendModules`
#
# Process:
#
# 1. Create keys
#   $ sudo sbctl create-keys
#
# 2. Configure NixOS secureboot (activate this profile)
#
# 3. Reboot into UEFI firmware settings
#   $ sudo systemctl reboot --firmware-setup
#
# 4. Enable Secure Boot in UEFI firmware
#   b. Select "Administrator Secure Boot"
#   c. Select "Erase all Secure Boot Settings"
#   d. Press "F10" to save and exit
#
# 4. Reboot
#   $ sudo systemctl reboot
#
# 5. Enroll keys
#   $ sudo sbctl enroll-keys --microsoft
#
# 6. Reboot
#   $ sudo systemctl reboot --firmware-setup
#
# 7. Enable Secure Boot
#    a. Select "Administrator Secure Boot"
#    b. Enable "Enforce Secure Boot"
#
# 7. Test
#   $ bootctl status
#
# TODO: TPM2.0 authenticated boot
# TODO: Boot counting
# TODO: sops-nix enrollment of Secure Boot keys
# TODO: impermanence persist /etc/secureboot
# TODO: generators.install-iso add secure boot setup script.
let
  inherit (lib) mkDefault mkForce;
  sbctl = lib.getExe pkgs.sbctl;
in
{
  imports = with inputs.lanzaboote.nixosModules; [lanzaboote uki];
  boot = {
    lanzaboote = mkDefault {
      enable =  true;
      # enrollKeys = true;
      configurationLimit = config.boot.loader.systemd-boot.configurationLimit or 20;
      pkiBundle = "/etc/secureboot"; #config.sops.secrets.secureboot-keys.path;
      # publicKeyFile  = config.sops.secrets.secureboot-pubkey.path;
      # privateKeyFile = config.sops.secrets.secureboot-privkey.path;
    };
    loader = {
      grub.enable = mkForce false;
      systemd-boot.enable = mkForce false;  #mkForce (!lanzaboote.enable);
      #uki = { enable = mkDefault false; stub = "path-to-uki-stub"; };
    };
  };

  # sops.secrets.secureboot = lib.mkIf config.boot.lanzaboote.enable {
  #   sopsFile = ../../hosts/${config.networking.hostName}/secrets/secureboot.yaml;
  #   path = "/etc/secureboot";
  #   owner = "root";
  #   group = "root";
  # };
  # sops.secrets = lib.mkIf config.boot.lanzaboote.enable {
  #   secureboot-pubkey  = { path = "/etc/secureboot/db/db.pem"; owner="root"; group="root"; };
  #   secureboot-privkey = { path = "/etc/secureboot/db/db.key"; owner="root"; group="root"; };
  #};

  environment.systemPackages = [ 
    # sbctl: Secure Boot - debug & troubleshoot
    pkgs.sbctl
    # (pkgs.writeShellScript "secureboot-enroll.sh" ''
    #     echo 'Creating keys...'
    #     echo '> sbctl create-keys'
    #     ${sbctl} create-keys
    #       \ && echo 'Created keys.'
    #       \ || echo 'Failed to create keys.'
    #     ${sbctl} verify
    # '')
    # (pkgs.writeShellScript "secureboot-check-generations.sh" ''
    #   sbctl verify /boot/EFI/Linux/nixos-generation-*.efi
    # '')
  ];
}
