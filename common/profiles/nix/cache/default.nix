{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./binary-caches.nix
    ./ccache.nix
    #./distcc.nix
    #./sccache.nix
  ];
}
