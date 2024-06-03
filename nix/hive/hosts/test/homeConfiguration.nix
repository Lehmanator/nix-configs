{ inputs, cell, super, ... }@args:
#builtins.trace ([ "HOME-TEST" ] ++ (builtins.attrNames self))
#let
#  nixosConfiguration =
#    if builtins.hasAttr "meta" self then
#      self.meta.nixosConfiguration
#    else if builtins.hasAttr "nixosConfiguration" self then
#      self.nixosConfiguration
#    else {
#      imports = [ ];
#      system.stateVersion = "23.11";
#      bee = rec {
#        inherit (inputs) darwin;
#        system = "x86_64-linux";
#        home = inputs.home-manager;
#        pkgs = cell.pkgs.unstable-with-overlays;
#        #pkgs = import inputs.nixpkgs { inherit system; };
#      };
#    };
#  home1 =
#    if builtins.hasAttr "meta" self then {
#      inherit (nixosConfiguration.system) stateVersion;
#      username = self.meta.specialArgs.user or "meta";
#    } else if builtins.hasAttr "specialArgs" self then {
#      inherit (nixosConfiguration.system) stateVersion;
#      username = self.specialArgs.user or "nixos";
#    } else {
#      inherit (nixosConfiguration.system) stateVersion;
#      username = "wtf";
#    };
#  home = home1 // { homeDirectory = "/home/${home1.username}"; };
#in
{
  inherit (super.nixosConfiguration) bee;

  imports = with inputs; [
    nix-flatpak.homeManagerModules.nix-flatpak
  ] ++ cell.pops.homeProfiles.exports.exportModulesRecursive;

  #inherit (self.meta.nixosConfiguration) bee;
  #home = rec {
  #  inherit (self.meta.nixosConfiguration.system) stateVersion;
  #  username =
  #    if builtins.hasAttr "specialArgs" self then
  #      self.specialArgs.user
  #    else if builtins.hasAttr "meta" self then
  #      self.meta.specialArgs.user
  #    else
  #      "samuel";
  #  homeDirectory = "/home/${username}";
  #};

  home = rec {
    inherit (super.nixosConfiguration.system) stateVersion;
    username = "red";
    homeDirectory = "/home/${username}";
  };
}
