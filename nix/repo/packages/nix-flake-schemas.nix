{inputs, cell,}@cellArgs:
let
  pkgs = inputs.nixpkgs.legacyPackages.${pkgs.system};
  inherit (pkgs) lib;
in
pkgs.nixVersions.nix_2_21.overrideAttrs (oldAttrs: {
  src = pkgs.fetchFromGitHub {
    url = "NixOS";
    repo = "nix";
    rev = "d76e5fb297eec5163dacf1346b2fc07562526386";
    hash = lib.fakeHash;
  };
  # patches = oldAttrs.patches ++ [
  #   (pkgs.fetchpatch {
  #     url = "https://patch-diff.githubusercontent.com/raw/NixOS/nix/pull/8892.patch";
  #     hash = "sha256-T3oZCVB3UeNQ+GZACigFgPBLSLgzJrZ9Z5smJp/8ByY=";
  #   })
  # ];
})
