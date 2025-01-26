{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.arion.nixosModules.arion];
  virtualisation.arion = {
    backend =
      if (config.virtualisation.podman.enable && config.virtualisation.podman.dockerSocket.enable)
      then "podman-socket"
      else "docker";

    # https://docs.hercules-ci.com/arion/options#_enabledefaultnetwork
    # projects = {
    #   name = {
    #     enableDefaultNetwork = lib.mkDefault true;
    #   };
    # };
  };
}
