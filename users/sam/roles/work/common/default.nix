{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    # NOTE: samba.nix passed drives=["Shared"] by default
    ./.
  ];
}
