{ lib, pkgs, ... }: 
let
  prefer-flatpak = true;
in
{
  services.flatpak = lib.mkIf prefer-flatpak {
    remotes = [{ name = "Valent"; location = "https://valent.andyholmes.ca/repo"; }];
    packages = ["ca.andyholmes.Valent"];
  };
  home.packages = lib.mkIf (! prefer-flatpak) [ pkgs.valent ];
  programs.gnome-shell.extensions = [{ package = pkgs.gnomeExtensions.valent; }];
}
