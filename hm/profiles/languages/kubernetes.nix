{ config, lib, pkgs, ... }:
{
  imports = [./docker.nix ./yaml.nix];

  # --- Packages -----------------------------------------------------
  # TODO: Distinguish between Kubernetes user & Kubernetes admin
  home.packages = [
    pkgs.kubectl
    pkgs.k9s
    pkgs.helm
    pkgs.helmfile
    pkgs.vals
  ];

  # TODO: kubeadm, k3d/k3s/rke2
  home.shellAliases = rec {
    helm = lib.getExe pkgs.helm;  # Needed to prevent launching Helm GUI app if installed
    h = helm;
    kube = lib.getExe pkgs.kubectl;
    k = kube;
    k9 = lib.getExe pkgs.k9s;
  };

  # --- Editors ------------------------------------------------------
  # TODO: Neovim, VSCodium
  # programs.neovim.plugins = [];

  programs.helix.extraPackages = [];
  programs.zed-editor.extensions = ["helm"];
}
