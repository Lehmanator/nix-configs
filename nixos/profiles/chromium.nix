{ inputs, config, lib, pkgs, ... }:
{
  imports = [];
  home-manager.sharedModules = [(inputs.self + /hm/profiles/chromium.nix)];

  programs.chromium = {
    enable = lib.mkDefault true;
    defaultSearchProviderEnabled = lib.mkDefault true;
  };

}
