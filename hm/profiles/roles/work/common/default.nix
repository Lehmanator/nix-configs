{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # NOTE: samba.nix passed drives=["Shared"] by default
  imports = [ ./. ];
}
