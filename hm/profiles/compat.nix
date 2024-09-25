{ inputs
, config, lib, pkgs
, osConfig
, ...
}:
#
# nix-ld: Run unpatched dynamic binaries on NixOS.
#  Repo: https://github.com/nix-community/nix-ld
#
# nix-alien: Use nix-ld to auto download necessary dependencies for you
#  Repo: https://github.com/thiagokokada/nix-alien
#
let
  hasAlienInput = inputs ? "nix-alien";
  hasNixLd = lib.attrByPath ["programs" "nix-ld" "enable"] false osConfig; 
  alienPackages = inputs.nix-alien.packages.${pkgs.stdenv.system};
in
{
  home.packages = [
  ] ++ lib.optionals hasAlienInput [
    alienPackages.nix-alien            # Run binary in FHS shell w/ req shared deps
    # alienPackages.nix-alien-find-libs  # Lists all libs needed for binary
    # alienPackages.nix-alien-ld         # Shell w/ NIX_LD_LIBRARY_PATH=<depsPaths>. Use w/ nix-ld
  ] ++ lib.optional (! hasNixLd) pkgs.nix-ld
  ;
}
