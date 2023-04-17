{
  self,
  system,
  inputs,
  config, lib, pkgs,

  host, network,
  ...
}:
let
in
{
  imports = [

  ];

  networking.domain = "pi.wine";
  networking.search = [
    "piwine.com"
    "pi.wine"
    "pi.local"
    "dev.pi.wine"
    "beta.pi.wine"
    "prod.pi.wine"
    "test.pi.wine"
  ];

}
