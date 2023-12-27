{ inputs
, config
, lib
, pkgs
, osConfig
, nixosConfig
, ...
}:
{
  imports = [
    ../../profiles
    ../../profiles/devices/fajita.nix
    ../../profiles/devices/pinetime.nix
    ../../profiles/devices/sawfish.nix

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
