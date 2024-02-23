{modulesPath, ...}: {
  imports = [
    ../../profiles/nixos
    ../../profiles/nixos/boot
    ../../profiles/nixos/locale
    ../../profiles/nixos/network
    ../../profiles/nixos/server/headscale.nix
    ../../profiles/nixos/server/keycloak.nix
    ../../profiles/nixos/server/lldap.nix
    ../../profiles/nixos/server/wireguard.nix
    ../../profiles/nixos/shell
    ../../profiles/nixos/users
    #../../profiles/nixos/hardware/fwupd.nix
    #../../profiles/nixos/hardware/tpm2.nix
    #../../profiles/nixos/security/sops.nix
    #../../profiles/nixos/server/openldap.nix
    #../../profiles/common/editor
  ];
}
