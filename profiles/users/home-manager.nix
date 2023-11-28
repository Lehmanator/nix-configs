{ inputs, self
, config, lib, pkgs
, modulesPath
, user ? "sam"
#, system ? "x86_64-linux"
#, usernames ? []
#, modules ? []
#, specialArgs ? [ ]
,  ...
}:
let
  userConfigs = {};

  # TODO: lib.list.zipToAttrs ?
  getUserConfigs = names: lib.lists.forEach (names) (u: (import "../users/${u}" {} ));
in
{
  # Modules to load for all home-manager configurations
  sharedModules = with inputs; [
    #(import ./users/default/nixos {};)
    impermanence.nixosModules.home-manager
    nixpkgs-android.hmModule
    arkenfox.hmModules.default
    sops-nix.homeManagerModules.sops
  ]; #++ modules;

  useGlobalPkgs = false;
  useUserPackages = true;
  extraSpecialArgs = { inherit self inputs user; };
  #users.<name> = import "../users/${username}";
}
