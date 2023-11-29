{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  # TODO: Make devShell with pkgs.sops installed
  #imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../hosts/${config.networking.hostName}/secrets/default.yaml;
    age = {
      #generateKey = true;
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; #"/etc/ssh/ssh_host_rsa_key"];
      #keyFile = "/var/lib/sops-nix/sops-host-age.privkey";
      #lib.map (k: k.path) config.services.openssh.hostKeys;  # TODO: Filter to type="rsa"
    };
    #gnupg = {
    #  home = "/var/lib/sops";
    #  #home = "/root/.local/share/gnupg";
    #  #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" "/etc/ssh/ssh_host_rsa_key" ];
    #};

    # --- Secrets ---
    secrets = {
      #  user-default-password = { group = "users"; };
      #  user-root-password    = { owner = "root"; group = "root"; };
      #
      #  # TODO: Move to NixOS profile for disk encryption
      #  disk-default-password = { owner = "root"; group = "root"; };
      #  disk-default-keyfile  = { owner = "root"; group = "root"; };
      test-host-secret = { };
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
