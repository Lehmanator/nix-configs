{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./apparmor.nix # Desktop only?
    ./auditd.nix
    ./polkit.nix # Desktop only?
    ./sops.nix
    ./sudo-rs.nix
    #./networking.nix
  ];

  security = lib.mkIf (pkgs.system == "x86_64-linux") {
    protectKernelImage = true;
  };
}
