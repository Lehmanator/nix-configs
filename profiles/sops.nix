{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    #inputs.sops-nix.nixosModules.sops
  ];

  # --- Packages ---------------------------------------------------------------
  environment.systemPackages = [
    pkgs.sops
    pkgs.kustomize-sops
    pkgs.terraform-providers.sops
  ];

  # --- Config -----------------------------------------------------------------
  #sops.defaultSopsFile = ../hosts/${config.networking.hostName}/secrets.yaml;


  # --- Secrets ----------------------------------------------------------------
  #sops.secrets = {
  #  user-default-password = { group = "users"; };
  #  user-root-password    = { owner = "root"; group = "root"; };
  #
  #  # TODO: Move to NixOS profile for disk encryption
  #  disk-default-password = { owner = "root"; group = "root"; };
  #  disk-default-keyfile  = { owner = "root"; group = "root"; };
  #};

}
