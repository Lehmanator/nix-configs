{ inputs
, config, lib, pkgs
, ...
}:
# 
# let
#   sbctl = lib.getExe pkgs.sbctl;
#   enroll-script = pkgs.writeShellApplication "secureboot-encroll.sh" ''
#     echo 'Creating keys...'
#     echo '> sbctl create-keys'
#     ${sbctl} create-keys
#       \ && echo 'Created keys.'
#       \ || echo 'Failed to create keys.'
#     ${sbctl} verify
#   '';
# in
{

  # --- SecureBoot ---
  # https://github.com/nix-community/lanzaboote
  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  # https://wiki.archlinux.org/title/Secure_Boot#Booting_an_installation_medium
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
  #
  # TODO: TPM2.0 authenticated boot
  # TODO: Boot counting
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot = {

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi"; # Default: `/boot`  # TODO: `XBOOTLDR` / `ESP` splitting. # TODO: Rewrite to `/efi`?
      };
      grub.enable         = lib.mkForce false;
      systemd-boot.enable = lib.mkForce false;
    };

    # bootspec = {
    #   enable = true;           # Write bootspec docs for each build.
    #   enableValidation = true; # Validate bootspec documents upon each build.
    #   #extensions = {};         #  ^ Introduces build-time Golang dep Cuelang. Make certain bootspec docs are correct.
    # };
    # initrd.systemd = {
    #   enable = true;
    #   enableTpm2 = true;
    # };

  };

  # Util to sign Secure Boot keys, etc.
  environment.systemPackages = [ pkgs.sbctl ];

  # TODO: sops-nix enrollment of Secure Boot keys
  # TODO: impermanence persist /etc/secureboot
  # TODO: generators.install-iso add secure boot setup script.
}
