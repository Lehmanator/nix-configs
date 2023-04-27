{
  self,
  system,
  inputs,
  config, lib, pkgs,

  host, network,
  ...
}:
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

  services.onedrive.enable = true;

  # See: https://wiki.generaloutline.com/share/dfa77e56-d4d2-4b51-8ff8-84ea6608faa4
  #services.outline.azureAuthentication = {};

  #services.davmail.enable = true;
}
