{
  inputs,
  lib,
  pkgs ? let
    lock =
      (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: let
  # --- Helpers ------------------------
  # Merges a list of attrsets each representing a devShell into one attrset before passing to `mkShell`
  # TODO: Figure out if `recursiveMerge` merges lists too or if that needs to be handled manually.
  mergeShells = with shellProfiles;
    extendList: newShell:
      lib.attrsets.foldAttrs (item: acc: lib.recursiveMerge acc item)
      [baseProfile] (extendList ++ [newShell]);

  # --- Secrets ------------------------
  sops-nix =
    if (inputs ? sops-nix)
    then inputs.sops-nix
    else
      builtins.fetchTarball {
        url = "https://github.com/Mic92/sops-nix/archive/master.tar.gz";
      };
  sops-hook =
    if (inputs ? sops-nix)
    then sops-nix.packages.${pkgs.system}.sops-import-keys-hook
    else (pkgs.callPackage sops-nix {}).sops-import-keys-hook;

  # --- Neovim -------------------------
  nvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim {
    plugins.lsp.enable = true;
  };
  # --- OR ---
  #makeNixvimWithModule {
  #  pkgs =
  #  module =
  #  extraSpecialArgs = {inherit inputs; config = {GET_NIXOS_CONFIG}; osConfig={GET_HM_CONFIG};};
  #};
  # TODO: in lib{

  # --- Profile Definition ---
  baseProfile = {
    name = "base";

    NIX_ENFORCE_PURITY = 1;
    #NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake recursive-nix";
    nixConfig.experimental-features = ["nix-command" "flakes" "repl-flake" "recursive-nix"];
    nativeBuildInputs = [pkgs.home-manager pkgs.nixpkgs-fmt pkgs.nixUnstable];
  };

  shellProfiles = rec {
    deployment = mergeShells [git] {
      name = "deployment";
      nativeBuildInputs = [pkgs.colmena];
    };

    fun = {
      name = "fun";
      nativeBuildInputs = [pkgs.cowsay];
    };

    git = {
      name = "git";
      nativeBuildInputs = [pkgs.gitFull];
      # TODO: Set `access-token` in `nix.conf`
      nixConfig.access-tokens = ["github.com="];
    };

    kubernetes = mergeShells [deployment] {
      name = "kubernetes";
      nativeBuildInputs = [
        # #
        pkgs.kubeadm # #
        pkgs.kubectl # #
        pkgs.kubectx # #
        pkgs.kubernetes-helm # #
        pkgs.kubetail # #
        pkgs.kustomize # #
        pkgs.krew # #
        pkgs.yamllint # # Linter for YAML files
        pkgs.yq # # Util for working with YAML like jq for JSON
        pkgs.k9s # # Interactive ncurses GUI for kubectl
      ];
    };

    nix = mergeShells [git] {
      name = "nix";
      NIXPKGS_ALLOW_UNFREE = 1;
      nativeBuildInputs = [pkgs.nixUnstable pkgs.nixpkgs-fmt pkgs.deadnix];
    };

    neovim = mergeShells [] {
      name = "neovim";
      buildInputs = [nvim];
      nativeBuildInputs = [];
    };

    rust = mergeShells [git] {
      name = "rust";
      buildInputs = [pkgs.cargo pkgs.rust-analyzer pkgs.clippy];
    };

    secrets = mergeShells [git] {
      name = "secrets";
      sopsCreateGPGHome = true;
      sopsGPGHome = "${toString ./.}/.git/gnupg";
      sopsPGPKeyDirs = ["${toString ./.}/hosts/fw/keys" "${toString ./.}/users/sam/keys"];
      sopsPGPKeys = [
        "${toString ./.}/hosts/fw/gpg.asc"
        "${toString ./.}/users/sam/gpg.asc"
      ];
      nativeBuildInputs = [
        sops-nix.packages.${pkgs.system}.sops-import-keys-hook
        pkgs.sops
        pkgs.ssh-to-age
        pkgs.ssh-to-pgp
        pkgs.gnupg
        pkgs.age
        pkgs.rage
        pkgs.vault
      ];
    };

    default = mergeShells [kubernetes neovim rust secrets] {
      name = "default";
      nativeBuildInputs = [];
    };
  };
  ##inputs.devshell.lib.mkShell {lib.evalModules builtins.attrValues rec {...};
in
  with shellProfiles; {
    default = mergeShells [deployment git kubernetes neovim nix rust secrets];
  }
#lib.recursiveMerge
#(lib.mapAttrs (n: v: pkgs.mkShell (lib.recursiveMerge shellProfiles.base v))
#  shellProfiles) {}
