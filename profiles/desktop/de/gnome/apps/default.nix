{
  self,
  system,
  inputs,
  userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
    #./default.nix
    #./epiphany.nix
  ];
  environment.systemPackages = with pkgs; [
    gnome.gnome-software
  ];
  programs.evince.enable = true;
  programs.evolution.enable = true;
  programs.evolution.plugins = [ pkgs.evolution-ews ];
  programs.firefox.nativeMessagingHosts.gsconnect = true;
  programs.geary.enable = true;
  programs.seahorse.enable = true;

  services.gnome = {
    core-developer-tools.enable = true;
    core-shell.enable = true;
    core-utilities.enable = true;

    evolution-data-server.enable = true;
    #evolution-data-server.plugins = [
    #];
    games.enable = true;
    gnome-keyring.enable = true;
    gnome-remote-desktop.enable = true;
    sushi.enable = true;
  };
}
