{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./samba-drives.nix  # Samba
  ];

}
