{ config, lib, pkgs, ... }:
{
  # TODO: Fix "Child process killed by signall 11" on launch.
  #   - Need to add program to PATH?
  #   - https://github.com/ddterm/gnome-shell-extension-ddterm
  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.ddterm;
      id = "ddterm@amezin.github.com";        # ID needed for auto-enable?
    }
  ];
  home.packages = [pkgs.gnomeExtensions.ddterm];

  # TODO: Settings
  # dconf.settings."com/github/amezin/ddterm" = {
  # };
}
