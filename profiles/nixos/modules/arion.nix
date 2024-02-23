{ inputs
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.arion.nixosModules.arion ];
  virtualisation.arion = {
    backend = lib.mkDefault true;
    #backend = config.virtualisation.podman.enable;

    # https://docs.hercules-ci.com/arion/options#_enabledefaultnetwork
    #projects = {
    #  name = {
    #    enableDefaultNetwork = lib.mkDefault true;
    #  };
    #};
  };

}
