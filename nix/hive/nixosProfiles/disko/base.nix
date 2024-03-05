{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.self.packages.${pkgs.system}) disko disko-doc;
  inherit (config.networking) hostName domain fqdn;
in {
  imports = [inputs.disko.nixosModules.disko];
  disko =
    (inputs.self.diskoConfigurations.${hostName} {
      inherit inputs config lib pkgs;
    })
    // {
      enableConfig = lib.mkDefault true;
    };
  environment.systemPackages = [disko disko-doc];
  services.nginx.virtualHosts = let
    locations = {"/disko".root = "${disko}/index.html";};
  in {
    # Add disko-doc to webserver
    localhost = {inherit locations;};
    "nixos-docs.${fqdn}" =
      lib.mkIf (domain != "" && domain != null) {inherit locations;};
  };
}
