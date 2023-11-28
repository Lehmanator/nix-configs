{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./apparmor.nix
    ./auditd.nix
    #./networking.nix
  ];

  security = {
    protectKernelImage = true;
  };
}
