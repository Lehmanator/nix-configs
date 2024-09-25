{ config, lib, ... }:
{
  # TODO: Make this display when home-manager integrated in NixOS
  news.display = "show";

  # home-manager manuals
  manual = {
    html.enable     = true;  # $ home-manager-help
    json.enable     = true;  # $ jq '.' $profileDir/share/doc/home-manager/options.json
    manpages.enable = true;  # $ man home-configuration.nix
  };

  programs.home-manager.enable = true;
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };

  home = {
    enableDebugInfo = lib.mkDefault true;
    enableNixpkgsReleaseCheck = true;      # Check for mismatched hm/nixos releases
    shellAliases.hm = lib.mkIf config.programs.home-manager.enable "home-manager";
  };
}
