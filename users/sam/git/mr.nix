{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];

  # TODO: Enable mr (VCS repo manager)
  programs.mr = {
    enable = true;
    settings = {
      config = { checkout = "git clone git@github.com:lehmanator/nix-configs.git"; update = "git pull"; };
      nixpkgs = { checkout = "git clone git@github.com:NixOS/nixpkgs.git"; update = "git pull --rebase"; };
      nur = { checkout = "git clone git@github.com:lehmanator/nur-repo.git"; };
      passwords = { checkout = "git clone git@github.com:lehmanator/keepass.git"; update = "git pull"; };
    };
  };

}
