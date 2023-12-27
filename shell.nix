{ inputs
, lib
, pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/${lock.rev}.tar.gz"; sha256 = lock.narHash; };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}:
let
  sops-nix =
    if (inputs ? sops-nix)
    then inputs.sops-nix
    else builtins.fetchTarball { url = "https://github.com/Mic92/sops-nix/archive/master.tar.gz"; };
  sops-hook =
    if (inputs ? sops-nix)
    then sops-nix.packages.${pkgs.system}.sops-import-keys-hook
    else (pkgs.callPackage sops-nix { }).sops-import-keys-hook;
in
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake recursive-nix";
    sopsPGPKeyDirs = [
      "${toString ./.}/hosts/fw/keys"
      "${toString ./.}/users/sam/keys"
    ];
    sopsPGPKeys = [
      "${toString ./.}/hosts/fw/gpg.asc"
      "${toString ./.}/users/sam/gpg.asc"
    ];
    sopsCreateGPGHome = true;
    sopsGPGHome = "${toString ./.}/.git/gnupg";
    nativeBuildInputs = with pkgs; [
      gitFull
      # --- Nix ---
      nixUnstable
      home-manager
      colmena
      nixpkgs-fmt
      # --- Sops ---
      sops-nix.packages.${pkgs.system}.sops-import-keys-hook
      sops
      ssh-to-age
      ssh-to-pgp
      gnupg
      age
      rage
      vault
      # --- Kubernetes ---
      kubeadm
      kubectl
      kubectx
      kubernetes-helm
      kubetail
      kustomize
      krew
      yamllint
      k9s
    ];
  };
}

#inputs.devshell.lib.mkShell {
#};
