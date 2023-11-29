{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  # TODO: Use newer pmbootstrap v2.0.0 from nixpkgs pull request (curr v1.53.1)
  #nixpkgs.overlays = [
  #  (final: prev: { pmbootstrap-latest = final.callPackage ../../../../pkgs/pmbootstrap.nix { }; })
  #];
  home.packages = [
    # --- pmbootstrap: flash PostmarketOS ---
    #(pkgs.callPackage ../../../../pkgs/pmbootstrap.nix)
    #pkgs.pmbootstrap-latest
    pkgs.pmbootstrap
  ];
}
