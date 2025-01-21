{ inputs, config, lib, pkgs, ... }:
{
  # Repo: https://github.com/YaLTeR/niri
  # Wiki: https://github.com/YaLTeR/niri/wiki/Getting-Started
  # Config:
  # - [Syntax: KDL](https://kdl.dev/)
  # - [Config Overview](https://github.com/YaLTeR/niri/wiki/Configuration:-Overview)
  # - [Defaults](https://github.com/YaLTeR/niri/blob/main/resources/default-config.kdl)
  #
  # Problem: Mesa drivers out of sync w/ Niri,
  #  Result: Usually black screen when starting niri from TTY.
  #     Fix: Match Niri's Mesa version with your system's version.
  #     See: https://nixos.wiki/wiki/Intel_Graphics
  #
  imports = [
    (inputs.self + /nixos/profiles/gdm.nix)
    (inputs.self + /nixos/profiles/gtk.nix)
    (inputs.self + /nixos/profiles/pipewire.nix)
    (inputs.self + /nixos/profiles/wayland.nix)
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Use host config if exists & fallback to default config file.
  # TODO: Reduce default config to most generic case
  # TODO: Create configs for system
  # TODO: Merging characteristics? Imports?
  environment.etc."niri/config.kdl".source = let
    hostConf = "${inputs.self}/nixos/hosts/${config.networking.hostName}/niri.kdl";
  in if builtins.pathExists hostConf then hostConf else ./niri.kdl;
}
