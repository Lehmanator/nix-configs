{ config, lib, pkgs, ... }:
{
  # TODO: Enable mr (VCS repo manager)
  programs.mr = {
    enable = true;
    settings = {
      config = { checkout = "git clone git@github.com:Lehmanator/nix-configs.git"; update = "git pull"; };
      nixpkgs = { checkout = "git clone git@github.com:NixOS/nixpkgs.git"; update = "git pull --rebase"; };
      nur = { checkout = "git clone git@github.com:Lehmanator/nur-repo.git"; };
    };
  };

}
