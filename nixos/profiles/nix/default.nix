{ inputs, lib, ... }: {
  imports = [
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs
    ./activation-script.nix
    ./cachix.nix
    ./nom.nix
    ./shell.nix
    #./ssh-serve-store.nix
  ];

  # --- Registry ---
  # Set NIX_PATH to contain all my flake inputs (with nixpkgs & config sorted first)
  # nix.settings.nix-path = with lib.lists; (builtins.map (i: "${i}=/etc/nix/inputs/${i}") (["nixpkgs" "self"]
  #     ++ (remove "nixpkgs" (remove "self" (builtins.attrNames inputs)))));
  nix = {
    generateNixPathFromInputs = lib.mkDefault true;
    generateRegistryFromInputs = lib.mkDefault true;
    linkInputs = lib.mkDefault true;
    settings.use-registries = lib.mkDefault true;
  };
  nixpkgs.flake = {
    setNixPath       = false;
    setFlakeRegistry = false;
  };

  environment = {
    extraOutputsToInstall = ["bin"]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    #sessionVariables.NIX_PATH = lib.intersperse ":" config.nix.settings.nix-path;
    #sessionVariables.NIX_PATH = with lib.lists; lib.intersperse ":" (builtins.map (i: "${i}=/etc/nix/inputs/${i}")
    #  (["nixpkgs" "self"] ++ (remove "nixpkgs" (remove "self" (builtins.attrNames inputs)))));
    shellAliases = {
      nix-closure-list         = "nix-store -qR `which $1`"; # TODO: Figure out how to allow
      nix-closure-tree         = "nix-store -q --tree `which $1`"; # arg not at end of alias
      nix-dependencies         = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";
    };
  };
}
