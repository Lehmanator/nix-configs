{ inputs
, config
, lib
, pkgs
, ...
}:
# udiskie: Userspace mount daemon
# Note: Requires loading ../../../profiles/hardware/udisks2.nix
{
  imports = [
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
    settings = {
      program_options = {
        udisks_version = 2;
        tray = true;
      };
      icon_names.media = [
        "media" #"media-optical"
      ];
    };
  };
}
