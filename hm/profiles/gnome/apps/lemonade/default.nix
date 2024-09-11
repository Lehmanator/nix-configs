{ pkgs, config, lib, ... }:
{
  # TODO: Package for nixpkgs (if not abandoned)
  services.flatpak.packages = [ "ml.mdwalters.Lemonade" ];
}
