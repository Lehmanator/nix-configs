{ inputs, config, lib, pkgs, ... }:
{
  # TODO: Make devShell with pkgs.sops installed
  imports = [ inputs.sops-nix.nixosModules.sops ];
  home-manager.sharedModules = [(inputs.self + /hm/profiles/sops.nix)];
  
  sops = {
    defaultSopsFile = (inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/default.yaml);
    age = {
      sshKeyPaths = map (k: k.path) (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys);
      #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #generateKey = true; keyFile = "/var/lib/sops-nix/sops-host-age.privkey";
    };

    #gnupg = {
    #  home = "/var/lib/sops";
    #  #home = "/root/.local/share/gnupg";
    #  #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" "/etc/ssh/ssh_host_rsa_key" ];
    #};

    secrets = {
      test-host-secret = { };
      #user-default-password = { group = "users"; };
      #user-root-password    = { owner = "root"; group = "root"; };
      ## TODO: Move to NixOS profile for disk encryption
      #disk-default-password = { owner = "root"; group = "root"; };
      #disk-default-keyfile  = { owner = "root"; group = "root"; };
    };
  };

  # --- Packages ---
  environment.systemPackages = [
    pkgs.age
    pkgs.rage
    pkgs.sops
    pkgs.kustomize-sops
    pkgs.terraform-providers.sops
    pkgs.ssh-to-age
  ] ++ (with inputs.sops-nix.packages.${pkgs.system}; [
    sops-import-keys-hook
    sops-init-gpg-key
    sops-install-secrets
    ssh-to-pgp
    #lint           # Broken build
    #sops-pgp-hook  # Deprecated
  ]);
}
