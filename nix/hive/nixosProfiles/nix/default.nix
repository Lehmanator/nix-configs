{ inputs, lib, ... }: {
  imports = [
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-nix-caches
    #./activation-script.nix
    #./cachix.nix
    #./nom.nix
    #./shell.nix

    #../../common/nix
    #../../linux/nix
    #./ssh-serve-store.nix

    #./cache ./features ./access-tokens.nix ./diff.nix ./gc.nix ./documentation.nix ./nixpkgs.nix, ./optimize.nix
    #./overlays.nix
    #./registry.nix
    #./sandbox.nix
    #./shell.nix
    #./aliases.nix
  ];

  # Set NIX_PATH to contain all my flake inputs (with nixpkgs & config sorted first)
  nix.settings.nix-path = with lib.lists;
    (builtins.map (i: "${i}=/etc/nix/inputs/${i}") ([ "nixpkgs" "self" ]
      ++ (remove "nixpkgs" (remove "self" (builtins.attrNames inputs)))));

  environment = {
    extraOutputsToInstall = [ "bin" ]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    #sessionVariables.NIX_PATH = lib.intersperse ":" config.nix.settings.nix-path;
    #sessionVariables.NIX_PATH = with lib.lists; lib.intersperse ":" (builtins.map (i: "${i}=/etc/nix/inputs/${i}")
    #  (["nixpkgs" "self"] ++ (remove "nixpkgs" (remove "self" (builtins.attrNames inputs)))));
    shellAliases = {
      # TODO: Figure out how to allow arg not at end of alias
      nix-closure-list = "nix-store -qR `which $1`";
      nix-closure-tree = "nix-store -q --tree `which $1`";
      nix-dependencies = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";
    };
  };
}
