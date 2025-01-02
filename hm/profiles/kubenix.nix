{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.kubenix.homeManagerModules.kubenix];
  sops.secrets.kubeconfig = {};
}
