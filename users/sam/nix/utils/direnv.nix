{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [

  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

}
