{ config, lib, pkgs, ... }: {
  imports = [
    ./binary-caches.nix
    ./ccache.nix
    #./cachix.nix
    #./distcc.nix
    #./sccache.nix
  ];
}
