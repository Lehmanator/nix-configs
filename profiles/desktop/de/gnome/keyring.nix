{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.gnupg.agent.pinentryFlavor = lib.mkDefault "gnome3";
  programs.seahorse.enable = config.services.gnome.gnome-keyring.enable;
  services.gnome.gnome-keyring = {
    enable = true;
  };

  # Enable GNOME keyring PAM module for all services that unlock with password
  # TODO: See if possible to unlock gnome-keyring with other auth methods like SSH keys & fingerprint.
  security.pam.services.login.enableGnomeKeyring = true;

}
