{
  self,
  system,
  inputs,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    adw-gtk3
  ];
  
  gtk.iconCache.enable = true;
}
