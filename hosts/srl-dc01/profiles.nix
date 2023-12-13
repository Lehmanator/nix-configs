{ modulesPath, ... }:
{
  imports = [
    #../../profiles/editor
    #../../profiles/hardware/fwupd.nix
    #../../profiles/hardware/tpm2.nix
    ../../profiles/security/sops.nix
    ../../profiles/server/headscale.nix
    ../../profiles/server/keycloak.nix
    ../../profiles/server/lldap.nix
    #../../profiles/server/openldap.nix
    ../../profiles/server/wireguard.nix
    ../../profiles/sshd.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/nixos
    ../../profiles/nixos/boot
    ../../profiles/shell
    ../../profiles/users
  ];
}
