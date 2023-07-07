{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    #inputs.sops-nix.homeManagerModules.sops
  ];

  home.packages = [
    pkgs.ssh-to-pgp
    pkgs.ssh-to-age
    pkgs.ssh-copy-id
    pkgs.ssh-import-id
    pkgs.ssh-key-confirmer
    pkgs.autossh
  ];
}
