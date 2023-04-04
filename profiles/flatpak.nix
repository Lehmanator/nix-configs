{ 
  self, 
  system, 
  host, userPrimary, 
  inputs, 
  config, lib, pkgs,
  ...
}:
{

  appstream.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  system.activationScripts.flatpakSystem.text = ''
  ''; # TODO: Replace with primary user
    #fc-cache -rf
    #ln -s /run/current-system/sw/share/X11/fonts /home/sam/.local/share/fonts

  services.flatpak.enable = true;
  services.packagekit.enable = true;

  users.users."sam".extraGroups = [ "flatpak" ];
}
