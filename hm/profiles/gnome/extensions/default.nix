{ config, lib, pkgs, ... }:
#
# Config for GNOME extensions that applies to all `gnomeProfiles`
#
# TODO: Pass `gnomeProfile` to current module as argument
# TODO: Dynamically import profile configs based on `gnomeProfile`
# - ./profiles/<gnomeProfile>
#
#
{
  imports = [
    ./ddterm.nix
    ./forge
  ];

  home.packages = [
    # Required for tophat & possibly other system monitor extensions
    pkgs.gtop
  ];
}
