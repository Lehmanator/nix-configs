{ config, lib, pkgs, ... }:
{
  # Forge - Tiling Shell GNOME Extension
  # https://github.com/forge-ext/forge
  # TODO: Compare with: https://github.com/domferr/tilingshell
  # TODO: Compare with: https://github.com/pop-os/shell
  # TODO: Configure to use Libadwaita CSS styles for tabs.
  environment.systemPackages = [pkgs.gnomeExtensions.forge];  # Tile, tab, & stack windows extension like pop-shell

  # TODO: Use dconf2nix to create Nix config files for each GNOME extension & place in this dir


  # TODO: Does Forge require any deps?
  # services.xserver.desktopManager.gnome.sessionPath = [];
}
