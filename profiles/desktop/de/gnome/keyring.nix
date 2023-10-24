{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  services = {
    accounts-daemon.enable = lib.mkDefault true; # AccountsService: access user account list & info via D-Bus
    gnome.gnome-keyring.enable = true; # GNOME Keyring daemon to handle user's security credentials.
    gsignond.enable = lib.mkDefault true; # D-Bus service to perform user auth on behalf of clients
    #dbus.packages = [
    #  pkgs.gcr_4 # GCR w/ tool UIs updated to GTK4
    #];
  };

  programs = {
    seahorse.enable = config.services.gnome.gnome-keyring.enable;
    #gnupg.agent.pinentryFlavor = lib.mkDefault "gnome3";
  };

  # Enable GNOME keyring PAM module for all services that unlock with password
  # TODO: See if possible to unlock gnome-keyring with other auth methods like SSH keys & fingerprint.
  security.pam.services.login.enableGnomeKeyring = config.services.gnome.gnome-keyring.enable;

  #environment.systemPackages = [
  #  #pkgs.gcr_4  # GCR with updated GTK4 tool UI
  #];

}
