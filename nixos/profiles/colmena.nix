{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/zhaofengli/colmena
  imports = with inputs.colmena.nixosModules; [ 
    assertionModule 
    deploymentOptions
    keyChownModule 
    keyServiceModule 
    # metaOptions
  ];

  # TODO: Default system config

  # deployment = {
  #   allowLocalDeployment = lib.mkDefault true;
  #   buildOnTarget = lib.mkDefault false;
  #   privilegeEscalationCommand = lib.mkDefault ["sudo" "-H" "--"];
  #   replaceUnknownProfiles = lib.mkDefault true;
  #   tags = [];
  #   targetHost = lib.mkDefault config.networking.hostName;
  #   targetPort = lib.mkDefault config.services.openssh.port;
  #   targetUser = lib.mkDefault "root";
  #   keys = {
  #   #  name = {
  #   #    destDir = "/run/keys";
  #   #    group = "root";
  #   #    keyCommand = [""];
  #   #    keyFile = config.sops.secrets.colmena-deployment-key-name.path;
  #   #    name = "name";
  #   #    permissions = "0600";
  #   #    text = "";
  #   #    uploadAt = "pre-activation"; #"post-activation";
  #   #    user = "root";
  #   #};
  # };

  # meta = {
  #   allowApplyAll = lib.mkDefault true;
  #   description = "A colmena hive";
  #   machinesFile = "";
  #   name = config.networking.hostName;
  #   nixpkgs = inputs.nixpkgs;
  #   nodeNixpkgs = {};
  #   nodeSpecialArgs = {inherit inputs pkgs user; };
  #   specialArgs = {inherit inputs pkgs user; };
  # };
}
