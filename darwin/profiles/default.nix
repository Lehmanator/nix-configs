{ inputs
, config
, lib
, pkgs
, user
, ...
}:
# TODO: Move all config that isn't MacOS-specific stuff to common file
{
  imports = [
    #inputs.srvos.nixosModules.common
    #inputs.srvos.nixosModules.mixins-nix-experimental
    #inputs.srvos.nixosModules.mixins-trusted-nix-caches
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index
    #{ programs.nix-index-database.comma.enable = true; }
    #./activate.nix
    ./alias.nix
    #./homed.nix
    #./home-manager.nix
    #./normalize.nix
    #../boot
    #../hardware
    ../locale
    #../network
    ../nix
    ../shell
    ../users
    ../nixos/sshd.nix
  ];

  appstream.enable = true;

  # --- Shell Environment ----------------------------------
  # FIXME: Correctly set NIX_PATH
  #nix.nixPath = [ "nixos=${inputs.nixos}" ];  #"nixos=${inputs.nixpkgs}"
  #nix.nixPath = ["nixos=/etc/nix/inputs/nixos:nixpkgs=/etc/nix/inputs/nixpkgs:home-manager=/etc/nix/inputs/home-manager"];
  #nix.registry = {
  #  nixos.flake = inputs.nixos;
  #  nixpkgs.flake = inputs.nixpkgs;
  #  home-manager.flake = inputs.home;
  #};
  #
  ## Place flake source in /etc/nixos
  ## TODO: Convert to divnix/hive first
  ##etc.nixos.source = inputs.self;
  #environment.etc = {
  #  "nix/inputs/nixos".source = inputs.nixos.outPath;
  #  "nix/inputs/home-manager".source = inputs.home.outPath;
  #};

}
