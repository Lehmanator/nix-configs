{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    (inputs.self + /nixos/profiles/apparmor.nix) # Desktop only?
    # (inputs.self + /nixos/profiles/auditd.nix)
    # (inputs.self + /nixos/profiles/polkit.nix) # Desktop only?
    (inputs.self + /nixos/profiles/security/sudo-rs.nix)
    # (inputs.self + /nixos/profiles/sops.nix)
    # (inputs.self + /nixos/profiles/security/networking.nix)
  ];

  #security = lib.mkIf (pkgs.system == "x86_64-linux") {
  #  protectKernelImage = true;
  #};

  # TODO: Equivalents: sudo-rs, doas, please
  environment.shellAliases = {
    s = lib.mkDefault "sudo";
    se = lib.mkIf config.security.sudo.enable "sudoedit"; 
  };
}
