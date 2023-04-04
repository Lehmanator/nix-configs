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

  environment.shellAliases = {
    fp = "flatpak";
    fpb = "flatpak build";
    fpo = "flatpak override";
    fpu = "flatpak update";
    fpi = "flatpak install";
    fpun = "flatpak uninstall";
    fpup = "flatpak update";
    fpu = "flatpak update";
    fps = "flatpak search";
  };
}
