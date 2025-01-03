{ inputs, ... }:
{
  imports = [
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/boot)
    (inputs.self + /nixos/profiles/server/headscale.nix)
    (inputs.self + /nixos/profiles/server/keycloak.nix)
    (inputs.self + /nixos/profiles/server/lldap.nix)
    (inputs.self + /nixos/profiles/server/wireguard.nix)
    (inputs.self + /nixos/profiles/locale)
    (inputs.self + /nixos/profiles/network)
    (inputs.self + /nixos/profiles/shell)
    (inputs.self + /nixos/profiles/users)
  ];
}
