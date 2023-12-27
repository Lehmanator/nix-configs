{ modulesPath, ... }:
{
  imports = [
    ../../profiles/server/headscale.nix
    ../../profiles/server/keycloak.nix
    ../../profiles/server/lldap.nix
    ../../profiles/server/wireguard.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles
    ../../profiles/boot
    ../../profiles/shell
    ../../profiles/users

    #../../profiles/hardware/fwupd.nix
    #../../profiles/hardware/tpm2.nix
    #../../profiles/security/sops.nix
    #../../profiles/server/openldap.nix
    #../../../common/profiles/editor
  ];
}
