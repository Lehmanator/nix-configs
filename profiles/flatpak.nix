{ self, system, userPrimary, inputs, config, lib, pkgs, ... }: {
  appstream.enable = true;

  services.flatpak.enable = true;
  services.packagekit.enable = true;

  users.users."sam".extraGroups = [ "flatpak" ];
}
