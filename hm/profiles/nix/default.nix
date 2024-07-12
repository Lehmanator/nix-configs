{
  inputs,
  overlays,
  packages,
  modules,
  templates,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  mkRegistryJSON = reg:
    builtins.toJSON {
      version = 2;
      flakes = lib.mapAttrsToList (n: v: {inherit (v) from to exact;}) reg;
    };
in {
  imports = [
    ./access-tokens.nix
    ./binary-caches.nix
    ./utils
    ./write-config.nix
    #./nix.nix
    #./nixpkgs.nix
  ];

  # TODO: Follow system, fallback to pkgs.nixUnstable
  #nix = lib.recursiveUpdate osConfig.nix {
  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest; # Needed for use-xdg-base-directories
    # TODO: Handle NixOS using system NIX_PATH when `home-manager.useGlobalPkgs=true`
    #settings.nix-path = lib.mkDefault [ "${config.xdg.configHome}/nix/inputs" ];
    #settings.nix-path = [ "${config.xdg.configHome}/nix/inputs" ];
    #settings.nix-path = (osConfig.nix.nixPath or [ ]) ++ [ "${config.xdg.configHome}/nix/inputs" ];
  };

  xdg.configFile =
    lib.recursiveUpdate {
      "nix/registry.json".text =
        mkRegistryJSON osConfig.nix.registry or config.nix.registry;
    } (lib.mapAttrs' (name: value: {
        name = "nix/inputs/${name}";
        value = {source = value.outPath;};
      })
      inputs);

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  #xdg.configFile = let
  #  hmReg = mkRegistryJSON config.nix.registry; # osConfig.nix.registry;
  #in lib.recursiveUpdate { "nix/registry.json".text = hmReg; }
  #{(lib.mapAttrs' (n: v: { n = "nix/inputs/${n}"; v = { source = v.outPath; }; }) inputs);

  home = {
    extraOutputsToInstall = ["bin"]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionVariables.NIX_BIN_DIR = "${config.nix.package}/bin";
    shellAliases = {
      nix-closure-list = "nix-store -qR `which $1`"; # TODO: Figure out how to allow
      nix-closure-tree = "nix-store -q --tree `which $1`"; # arg not at end of alias
      nix-dependencies = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";
    };
  };
}
