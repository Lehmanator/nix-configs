{ inputs, config, lib, pkgs, user, ... }:
{
  # https://github.com/nix-community/srvos
  imports = with inputs.srvos.nixosModules; [
    common
    mixins-nix-experimental
    mixins-trusted-nix-caches
    #desktop
    #server
    #mixins-cloud-init
    #mixins-nginx
    #mixins-systemd-boot
    #mixins-telegraf
    #mixins-terminfo
    #mixins-tracing
    #roles-github-actions-runner
    #roles-nix-remote-builder
  ];

  #home-manager.sharedModules = [ inputs.srvos.homemManagerModules.srvos ]; # No hmModule yet

  # TODO: Learn about `lib.extendModules`
}
