{ config, lib, pkgs, ... }: {
  home.packages = [
    # --- Helm ---
    pkgs.helmfile # Declarative spec for deploying Helm charts
    pkgs.helm-ls # Language server for Helm
    pkgs.helmsman # Helm Charts (k8s applications) as Code tool
    pkgs.kubernetes-helm
    pkgs.kubernetes-helmPlugins.helm-cm-push
    pkgs.kubernetes-helmPlugins.helm-diff
    pkgs.kubernetes-helmPlugins.helm-s3
    pkgs.kubernetes-helmPlugins.helm-git # The Helm downloader plugin that provides GIT protocol support
    pkgs.kubernetes-helmPlugins.helm-git # The Helm downloader plugin that provides GIT protocol support
    pkgs.kubernetes-helmPlugins.helm-secrets # A Helm plugin that helps manage secrets
  ];
}
