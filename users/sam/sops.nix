{ inputs
, self
, config
, lib
, pkgs
, user
, ...
}:
{
  #imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = ../../users/${user}/.secrets/default.yaml;
    keepGenerations = 10;

    age = {
      generateKey = true;
      sshKeyPaths = [
        "${config.home.homeDir}/.ssh/id_ed25519"
        "${config.home.homeDir}/.ssh/id_sops_ed25519"
        #"${config.home.homeDir}/.ssh/id_sops_rsa"
        #"${config.home.homeDir}/.ssh/id_rsa"
        #"${config.home.homeDir}/.ssh/id_fw_rsa"
      ];
      #  "${config.home.homeDir}/.ssh/id_ed25519" ];
      #keyFile = "${config.home.homeDir}/.local/secrets/sops-age.privkey";
    };

    gpupg = {
      home = config.programs.gnupg.homedir;
      #sshKeyPaths = [
      #  "${config.home.homeDir}/.ssh/id_rsa"
      #  "${config.home.homeDir}/.ssh/id_ed25519"
      #];
    };

    secrets = {
      test-user-secret = { };
    };
  };

  home.packages = [
    #pkgs.ssh-to-pgp
    pkgs.ssh-to-age
    pkgs.ssh-copy-id
    pkgs.ssh-import-id
    pkgs.ssh-key-confirmer

    pkgs.autossh

    pkgs.age
    pkgs.rage

    pkgs.sops
    pkgs.kustomize-sops
    pkgs.terraform-providers.sops

  ] ++ (with inputs.sops-nix.packages.${pkgs.system}; [
    sops-import-keys-hook
    sops-init-gpg-key
    sops-install-secrets
    ssh-to-pgp

    #lint           # Broken build
    #sops-pgp-hook  # Deprecated
  ]);
}
