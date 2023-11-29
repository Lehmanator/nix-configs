{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  # Settings for GNOME Display Manager (GDM)
  services.xserver.displayManager.gdm = {
    enable = true;
  };
  users.users.${user}.extraGroups = [ "gdm" ];
}
