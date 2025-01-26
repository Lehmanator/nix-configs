{
  config,
  lib,
  pkgs,
  ...
}: {
  environment = {
    shells = [pkgs.nushell];
    systemPackages = [
      pkgs.nushell
      pkgs.nushellPlugins.dbus
      pkgs.nushellPlugins.formats
      pkgs.nushellPlugins.gstat
      pkgs.nushellPlugins.highlight
      pkgs.nushellPlugins.net
      pkgs.nushellPlugins.polars
      pkgs.nushellPlugins.query
      pkgs.nushellPlugins.skim
      pkgs.nushellPlugins.units
      pkgs.nu_scripts
    ];
  };
}
