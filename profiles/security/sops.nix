{ inputs, self
, config, lib, pkgs
, ...
}:
{
  # TODO: Make devShell with pkgs.sops installed
  imports = [inputs.sops-nix.nixosModules.sops];

  # --- Packages ---
  environment.systemPackages = [
    pkgs.age
    pkgs.rage
    pkgs.sops
    pkgs.kustomize-sops
    pkgs.terraform-providers.sops
  ] ++ (with inputs.sops-nix.packages.${pkgs.system}; [
    #lint
    sops-import-keys-hook
    sops-init-gpg-key
    sops-install-secrets
    sops-pgp-hook
    ssh-to-pgp
  ]);

  # --- Config ---
  sops = {
    defaultSopsFile = ../hosts/${config.networking.hostName}/secrets.yaml;

    # --- Secrets ---
    secrets = {
    #  user-default-password = { group = "users"; };
    #  user-root-password    = { owner = "root"; group = "root"; };
    #
    #  # TODO: Move to NixOS profile for disk encryption
    #  disk-default-password = { owner = "root"; group = "root"; };
    #  disk-default-keyfile  = { owner = "root"; group = "root"; };
    };
  };

}
