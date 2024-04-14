{
  inputs,
  lib,
  pkgs,
  ...
}:
#let
#  #test =
#  #  lib.traceIf true "ARION ${builtins.toString (builtins.attrNames inputs)}"
#  #  inputs;
#in
{
  #imports = lib.traceIf true "ARION ${builtins.toString (builtins.attrNames inputs)}" [
  #  #inputs.arion.nixosModules.arion
  #  #inputs.std.inputs.arion.nixosModules.arion
  #  #inputs.arion.nixosModules.arion
  #];
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
