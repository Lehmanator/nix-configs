{ config, lib, pkgs, ... }:
{
  environment = {
    shellAliases = {
      nix-nurl = "nurl";
      n-nurl = "nurl";

      nix-nvfetcher = "nvfetcher";
      n-nvfetch = "nvfetcher";
    };

    systemPackages = [
      pkgs.nix-update # Update Nix packages
      pkgs.nurl # Automatically generate fetcher expressions from URLs
      pkgs.nvfetcher # Update package commits & hashes
    ];
  };
}
