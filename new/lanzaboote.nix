{ inputs, self
, config, lib, pkgs
, ...
}:
{
  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  # ```
  # $ bootctl status
  # $ sudo sbctl create-keys
  # $ sudo sbctl verify
  # $ sudo sbctl enroll-keys --microsoft
  # $ sudo reboot
  # $ bootctl status
  # ```
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  environment.systemPackages = [pkgs.sbctl];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
      # TODO: Encrypt with agenix/sops-nix?
      # TODO: Make sure persists via impermanence
    };
    loader = {
      grub.enable         = lib.mkForce false;
      systemd-boot.enable = lib.mkForce false;
    };
  };
  # TODO: Write /etc/machine-id
}
