{ inputs, ... }:
{ config, lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    environmentVariables = {
      inherit (config.home.sessionVariables) EDITOR VISUAL;
    };
    configFile = {
      text = ''
        plugin add ${lib.getExe pkgs.nushellPlugins.formats}
        plugin add ${lib.getExe pkgs.nushellPlugins.gstat}
        plugin add ${lib.getExe pkgs.nushellPlugins.net}
        plugin add ${lib.getExe pkgs.nushellPlugins.query}
        source nix-your-shell.nu

        let $config = {
          table_mode: rounded
          use_ls_colors: true 
        }
      '';
    };
  };
}
