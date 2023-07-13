{ self, inputs
, config, lib, pkgs
, user ? "sam"
, ...
}:
# Settings for GNOME Display Manager (GDM)
{
  imports = [
  ];

  services.xserver.displayManager.gdm = {
    enable = true;
  };
  users.users."${user}".extraGroups = ["gdm"];
}
