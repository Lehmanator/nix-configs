{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs; [
    self.nixosProfiles.polkit # Desktop only?
    self.nixosProfiles.sudo-rs
    #self.nixosProfiles.apparmor # Desktop only?
    #self.nixosProfiles.auditd
    #self.nixosProfiles.network-hardening  #./networking.nix
    #self.nixosProfiles.sops
  ];

  #security = lib.mkIf (pkgs.system == "x86_64-linux") {
  #  protectKernelImage = true;
  #};

  environment.shellAliases = {
    s = lib.mkDefault "sudo";
    se =
      lib.mkIf config.security.sudo.enable
      "sudoedit"; # TODO: Equivalents: sudo-rs, doas, please
  };
}
