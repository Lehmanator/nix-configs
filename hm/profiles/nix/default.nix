{ config, lib, pkgs, ... }:
let
  # mkRegistryJSON = reg: builtins.toJSON { version = 2; flakes = lib.mapAttrsToList (n: v: {inherit (v) from to exact;}) reg; };
  clip-bin = "${pkgs.wl-clipboard}/bin/wl-paste";
in {
  imports = [
    ./access-tokens.nix
    ./binary-caches.nix
    ./write-config.nix
    #./nix.nix
    #./nixpkgs.nix
  ];

  nix.package = lib.mkDefault pkgs.lix;

  # xdg.configFile = lib.recursiveUpdate {
  #   "nix/registry.json".text = mkRegistryJSON osConfig.nix.registry or config.nix.registry;
  # } (lib.mapAttrs' (name: value: {
  #   name = "nix/inputs/${name}";
  #   value = {source = value.outPath;};
  # }) inputs);

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
      flake = "nix flake";
      nf = "nix flake";
      repl = "nix repl";
      nfs = "nix flake show";
      nfsp = "nix flake show git+$(${clip-bin})";
      build = "nix build";
      derivation = "nix derivation";
      develop = "nix develop";
      fmt = "nix fmt";
      nedit = "nix edit";
      nenv = "nix env";
      nrun = "nix run";
      # npkg = "nix run nixpkgs#$(read -p \"Enter a package name\")";
      store = "nix store";
      why-depends = "nix why-depends";
      upgrade-nix = "nix upgrade-nix";
      profile = "nix profile";
    };
  };
}
