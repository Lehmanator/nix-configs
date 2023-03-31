{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
  ];

  programs.ccache.enable = true;
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
}
