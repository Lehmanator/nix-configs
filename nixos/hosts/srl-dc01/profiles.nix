{inputs, ...}: {
  imports = [
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/bash.nix)
    (inputs.self + /nixos/profiles/boot)
    (inputs.self + /nixos/profiles/locale-est.nix)
    (inputs.self + /nixos/profiles/server/headscale.nix)
    (inputs.self + /nixos/profiles/server/keycloak.nix)
    (inputs.self + /nixos/profiles/server/lldap.nix)
    (inputs.self + /nixos/profiles/server/wireguard.nix)
    (inputs.self + /nixos/profiles/user-primary)
    (inputs.self + /nixos/profiles/wireguard)
    (inputs.self + /nixos/profiles/zsh.nix)
  ];
}
