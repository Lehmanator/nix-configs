{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    # TODO: Determine whether lanzaboote options important/necessary for SecureBoot.
    # TODO: Determine whether lanzaboote module import still necessary for SecureBoot. (Included by default yet?)
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = [
    pkgs.sbctl                    # Util to sign Secure Boot keys, etc.
  ];

  boot.bootspec = {
    enable = true;            # Write bootspec docs for each build.
    enableValidation = true;  # Validate bootspec documents upon each build.
    #extensions = {};         #  ^ Introduces build-time Golang dep Cuelang. Make certain bootspec docs are correct.
  };

  # Initially, SecureBoot was only supported on GRUB2. # TODO: Check if still true.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

}
