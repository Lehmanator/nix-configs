{
  inputs,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = "${config.home.homeDirectory}/${config.xdg.configFile.flake.target}";
    clean = {
      # Conflicts with NixOS option `nix.gc.automatic`, so we only use if not enabled.
      enable = !(osConfig.nix.gc.automatic or false);
      dates = "weekly";
      extraArgs = "--keep-since 4d --keep 3";
    };
  };
  home.shellAliases = {
    os = "nh os";
    boot = "nh os boot";
    switch = "nh os switch";
    home = "nh home";
    search = "nh search";
    clean = "nh clean";
  };
}
