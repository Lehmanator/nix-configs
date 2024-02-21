{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./icons.nix   { enable = true;     }
    #./borders.nix { style = "rounded"; }
  ];
}
