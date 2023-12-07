{ inputs
, config
, lib
, pkgs
, ...
}:
{

  # --- SecureBoot ---
  # https://wiki.archlinux.org/title/Secure_Boot#Booting_an_installation_medium
  #
  # TODO: Lanzaboote
  # TODO: TPM2.0 authenticated boot
  # TODO: Boot counting
  #

  imports = [
    # TODO: Determine whether lanzaboote options important/necessary for SecureBoot.
    # TODO: Determine whether lanzaboote module import still necessary for SecureBoot. (Included by default yet?)
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot = {
    bootspec = {
      enable = true; # Write bootspec docs for each build.
      enableValidation = true; # Validate bootspec documents upon each build.
      #extensions = {};         #  ^ Introduces build-time Golang dep Cuelang. Make certain bootspec docs are correct.
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    initrd.systemd = {
      enable = true;
      enableTpm2 = true;
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi"; # Default: `/boot`  # TODO: `XBOOTLDR` / `ESP` splitting. # TODO: Rewrite to `/efi`?
      };
      # Initially, SecureBoot was only supported on GRUB2. # TODO: Check if still true.
      grub.enable = lib.mkForce false;
      systemd-boot.enable = lib.mkForce false;
    };
  };

  environment.systemPackages = [
    pkgs.sbctl # Util to sign Secure Boot keys, etc.
  ];

}
