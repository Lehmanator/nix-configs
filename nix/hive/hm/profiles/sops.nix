{ inputs, cell
, config, lib, pkgs
, osConfig
, user
, ...
}@moduleArgs:
let
  blockDir = "userProfiles";
in
{
  # imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    # defaultSopsFile = inputs.self + /users/${user}/secrets/default.yaml;
    # defaultSopsFile = ../../../users/${user}/secrets/default.yaml;
    defaultSopsFile = inputs.self + /nix/hive/${blockDir}/${config.home.username}/secrets/default.yaml;
    keepGenerations = 10;

    age = {
      #generateKey = true;
      sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
        "${config.home.homeDirectory}/.ssh/id_sops_ed25519"
      ];
      #  "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      #keyFile = "${config.home.homeDirectory}/.local/secrets/sops-age.privkey";
    };

    #gnupg = {
    #  home = config.programs.gpg.homedir;
    #  #sshKeyPaths = [
    #  #  "${config.home.homeDirectory}/.ssh/id_rsa"
    #  #  "${config.home.homeDirectory}/.ssh/id_ed25519"
    #  #];
    #};

    secrets = {
      test-user-secret = {};
      # test-shared-secret = {};
    };
  };

  # Restart user sops-nix.service unit on home-manager activation.
  home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    /run/current-system/sw/bin/systemctl start --user sops-nix
  '';

  home.packages =
    [
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
    ]
    ++ (with inputs.sops-nix.packages.${pkgs.system}; [
      sops-import-keys-hook
      sops-init-gpg-key
      sops-install-secrets
      ssh-to-pgp

      #lint           # Broken build
      #sops-pgp-hook  # Deprecated
    ]);
}
