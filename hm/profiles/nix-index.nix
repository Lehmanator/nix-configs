{ inputs, config, lib, pkgs, ... }:
{
  # imports = [ inputs.nix-index-database.hmModules.nix-index-database ];
  imports = [ inputs.nix-index.hmModules.nix-index ];

  programs.nix-index-database.comma.enable = lib.mkDefault true;
  programs.command-not-found.enable        = lib.mkDefault false;
}
