{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./apparmor.nix # Desktop only?
    #./auditd.nix
    ./polkit.nix # Desktop only?
    #./sops.nix
    ./sudo-rs.nix
    #./networking.nix
  ];

  security = lib.mkIf (pkgs.system == "x86_64-linux") {
    protectKernelImage = true;
  };

  environment.shellAliases = {
    s = lib.mkDefault "sudo";
    se = lib.mkIf config.security.sudo.enable "sudoedit"; # TODO: Equivalents: sudo-rs, doas, please
  };
}
