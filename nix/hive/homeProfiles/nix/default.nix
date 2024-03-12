{ inputs, osConfig, config, lib, pkgs, user, ... }:
let
  mkRegistryJSON = reg:
    builtins.toJSON {
      version = 2;
      flakes = lib.mapAttrsToList (n: v: { inherit (v) from to exact; }) reg;
    };
in
{
  imports = [
    ./access-tokens.nix
    ./binary-caches.nix
    ./garbage-collection.nix
    ./utils
    ./optimize.nix
    ./sandbox.nix
    ./write-config.nix
    #./nix.nix
    #./nixpkgs.nix
  ];

  # TODO: Follow system, fallback to pkgs.nixUnstable
  #nix = lib.recursiveUpdate osConfig.nix {
  nix = {
    channel.enable = lib.mkDefault false;
    # nixUnstable: Needed for use-xdg-base-directories
    package = lib.mkDefault pkgs.nixUnstable;

    settings = {
      allow-import-from-derivation = lib.mkDefault true;
      auto-optimise-store = lib.mkDefault true;

      allowed-users = lib.mkDefault [ "*" ];
      trusted-users = [ "root" "@wheel" "@builders" user ];
      build-users-group = lib.mkDefault "nixbld";

      connect-timeout = lib.mkDefault 10;

      keep-build-log = lib.mkDefault true;
      keep-derivations = lib.mkDefault true;
      keep-env-derivations = lib.mkDefault true;
      keep-going = lib.mkDefault false;
      min-free = lib.mkDefault 128 * 1000 * 1000;
      max-free = lib.mkDefault 1280 * 1000 * 1000;
      preallocate-contents = lib.mkDefault true;

      log-lines = lib.mkDefault true;
      use-xdg-base-directories = true;
      warn-dirty = lib.mkDefault false;
    };

    # TODO: Handle NixOS using system NIX_PATH when `home-manager.useGlobalPkgs=true`
    #settings.nix-path = lib.mkDefault [ "${config.xdg.configHome}/nix/inputs" ];
    #settings.nix-path = [ "${config.xdg.configHome}/nix/inputs" ];
    #settings.nix-path = (osConfig.nix.nixPath or [ ]) ++ [ "${config.xdg.configHome}/nix/inputs" ];
  };

  xdg.configFile = lib.recursiveUpdate
    {
      "nix/registry.json".text =
        mkRegistryJSON osConfig.nix.registry or config.nix.registry;
    }
    (lib.mapAttrs'
      (name: value: {
        name = "nix/inputs/${name}";
        value = { source = value.outPath; };
      })
      inputs);

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  #xdg.configFile = let
  #  hmReg = mkRegistryJSON config.nix.registry; # osConfig.nix.registry;
  #in lib.recursiveUpdate { "nix/registry.json".text = hmReg; }
  #{(lib.mapAttrs' (n: v: { n = "nix/inputs/${n}"; v = { source = v.outPath; }; }) inputs);

  home = {
    extraOutputsToInstall = [ "bin" ]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionVariables.NIX_BIN_DIR = "${config.nix.package}/bin";
    shellAliases = {
      # TODO: Figure out how to allow arg not at end of alias
      nix-closure-list = "nix-store -qR `which $1`";
      nix-closure-tree = "nix-store -q --tree `which $1`";
      nix-dependencies = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";
    };
  };
}
