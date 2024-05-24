{ inputs, cell, config, pkgs, ... }:
let
  # TODO: Move keys from <repo>/hosts/${host}/secrets/default.yaml to nix/hive/hosts/${host}/secrets/default.yaml
  # TODO: Edit path regex for hosts in <repo>/.sops.yaml
  # TODO: Uncomment next line and remove line after.
  #hostDir = inputs.self + nix/hive/hosts/${config.networking.hostName};
  hostDir = inputs.self + /hosts/${config.networking.hostName};
  hostSecretsDir = hostDir + /secrets;

  # TODO: Create secrets dir
  # TODO: Set sops.defaultSopsFile = sharedSecretsDir + /default.yaml
  sharedDir = inputs.self + /nix/hive/nixos;
  sharedSecretsDir = sharedDir + /secrets;

  getKeys = t:
    let
      keys = builtins.filter (k: k.type == t) config.services.openssh.hostKeys;
    in
    if builtins.length keys > 0 then
      keys
    else
      [ "/etc/ssh/ssh_host_${t}_key" ];
in
{
  # TODO: Make devShell with pkgs.sops installed
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = hostSecretsDir + /default.yaml;
    age = {
      sshKeyPaths = getKeys "ed25519";
      generateKey = true;
      #keyFile = "/var/lib/sops-nix/sops-host-age.privkey";
      #sshKeyPaths = map (k: k.path) (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys);
    };

    #gnupg = {
    #  home = "/var/lib/sops";
    #  #home = "/root/.local/share/gnupg";
    #  #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" "/etc/ssh/ssh_host_rsa_key" ];
    #};

    secrets = {
      test-host-secret = { sopsFile = hostSecretsDir + /default.yaml; };
      test-shared-secret = { sopsFile = sharedSecretsDir + /default.yaml; };

      #user-default-password = { group = "users"; };
      #user-root-password    = { owner = "root"; group = "root"; };
      ## TODO: Move to NixOS profile for disk encryption
      #disk-default-password = { owner = "root"; group = "root"; };
      #disk-default-keyfile  = { owner = "root"; group = "root"; };
    };
  };

  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
    #inputs.self.homeProfiles.sops
    { imports = [ cell.homeProfiles.sops ]; }
  ];

  # --- Packages ---
  environment.systemPackages = [ pkgs.age pkgs.rage pkgs.sops pkgs.ssh-to-age ]
    ++ (with inputs.sops-nix.packages.${pkgs.system}; [
    ssh-to-pgp
    sops-import-keys-hook
    sops-init-gpg-key
    sops-install-secrets
    sops-pgp-hook # Deprecated
    sops-pgp-hook-test
    lint # Broken build
  ])
    # --- Other Utils ---
    #++ lib.optional lib.nixos.hasKubernetes pkgs.kustomize-sops
    #++ lib.optional lib.nixos.hasTerraform pkgs.terraform-providers.sops
    #++ lib.optional config.programs.git.enable pkgs.pre-commit-hook-ensure-sops
    # --- Editor Plugins ---
    #++ lib.optional config.programs.neovim.enable pkgs.vimPlugins.nvim-sops
    #++ lib.optional config.programs.vim.enable pkgs.vimPlugins.nvim-sops
    #++ [
    #pkgs.emacsPackages.sops
    #pkgs.vscode-extensions.signageos.signageos-vscode-sops
    #]
  ;
}
