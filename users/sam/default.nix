{ inputs, config, lib, pkgs, osConfig, nixosConfig, ... }: {
  imports = [
    inputs.self.homeProfiles.devices-fajita
    inputs.self.homeProfiles.devices-nintendo-switch
    inputs.self.homeProfiles.devices-pinetime
    inputs.self.homeProfiles.devices-sawfish
    inputs.self.homeSuites.developer-default
    #../../profiles/hm

    ./git
    ./gpg.nix
    ./nix.nix
  ];

  #programs.gallery-dl.settings = {};

  #home.file."os-config" = {
  #  target = ".hm/os-config";
  #  #text = lib.generators.toPretty (lib.attrsets.filterAttrs (n: v: lib.elem n [ "meta" "_functor" "_toString" ])) osConfig;
  #  #text = lib.generators.toPretty
  #  text = lib.traceIf (osConfig ? users)
  #    (lib.attrsets.removeAttrs
  #      osConfig.users.users.${config.home.username}.openssh
  #      [ "meta" "_functor" "_toString" "toString" "_type" "system" "home" "packages" "home-manager" ]
  #    ) "true";
  #};
  #home.file."nixos-config" = {
  #  target = ".hm/nixos-config";
  #  #text = lib.generators.toPretty osConfig;
  #  text = lib.traceIf (osConfig ? users)
  #};
}
