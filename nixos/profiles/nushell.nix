{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (inputs.self + /nixos/profiles/shell.nix)
  ];

  # TODO: Remove bash, nushell config
  environment = {
    systemPackages = [pkgs.nushell];
    shells = [pkgs.nushell];
  };
}
