{ inputs
, config
, osConfig
, lib
, pkgs
, ...
}:
let
  defaults = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    extra-substituters = [ ];
    trusted-substituters = [
      "https://cache.nixos.org/"
    ];
    extra-trusted-substituters = [ ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    extra-trusted-public-keys = [ ];
  };
in
{
  imports = [
    # Use same caches as NixOS system. home-manager config will only define extra caches to add on top.
    ../../../profiles/nix/cache.nix
  ];

  # --- Binary Cache -------------------
  # TODO: Find more binary caches for big projects & common software
  nix.settings =
    if (osConfig ? home-manager && osConfig.home-manager.useGlobalPkgs)
    then osConfig.nix.settings
    else {
      #builders-use-substitutes = true; # Allow builders to use binary caches
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        #"https://nix-on-droid.cachix.org/"
        #"https://robotnix.cachix.org/"
        #"https://nrdxp.cachix.org/"
        #"https://numtide.cachix.org/"
        #"https://snowflakeos.cachix.org/"
      ];
      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        #"https://nix-on-droid.cachix.org/"
        #"https://nrdxp.cachix.org/"
        #"https://numtide.cachix.org/"
        #"https://snowflakeos.cachix.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        #"nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
        #"nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
        #"numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

  # TODO: Make dir `../cache` ?
  #
  # TODO: Move this config to: `../cache/binary.nix`  # Use Nix binary caches
  # TODO: Move this config to: `../cache/cachix.nix`  # Use private Cachix binary cache
  # TODO: Move this config to: `../cache/ccache.nix`  # Use compilation cache
  # TODO: Move this config to: `../cache/distcc.nix`  # Use distributed ccache
  # TODO: Move this config to: `../cache/sccache.nix` # Use Rust cache
  #
  # TODO: Move this config to: `../cache/host.nix`    # Host private Nix binary cache
  #
  # Use the system's ccache
  home.sessionVariables = lib.mkIf osConfig.programs.ccache.enable {
    CCACHE_DIR = osConfig.programs.ccache.cacheDir;
    CCACHE_COMPRESS = 1;
    CCACHE_UMASK = "007";
  };

}
