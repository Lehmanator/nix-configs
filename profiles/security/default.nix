{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./apparmor.nix # Desktop only?
    ./auditd.nix
    ./polkit.nix # Desktop only?
    ./sops.nix
    #./networking.nix
  ];

  security = {
    protectKernelImage = true;
  };
}
