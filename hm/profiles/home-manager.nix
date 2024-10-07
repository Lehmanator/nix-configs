{ config, lib, ... }:
{
  # TODO: Make this display when home-manager integrated in NixOS
  news.display = "show";

  # home-manager manuals
  manual = {
    # TODO: Create wrapper script for `home-manager-help` to:
    #       - navigate to options page
    #       - open to specific option
    # $ home-manager-help
    html.enable     = true;  

    # TODO: Create wrapper scripts for `options.json` to:
    #       - view with jq
    #       - view / search interactively
    # $ jq '.' $profileDir/share/doc/home-manager/options.json
    json.enable     = true;

    # $ man home-configuration.nix
    manpages.enable = true;
  };

  # Allow home-manager to install & manage itself
  # TODO: Figure out if this has any effect when managed by NixOS
  programs.home-manager.enable = true;
  # TODO: Figure out if this has any effect when managed by NixOS
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
