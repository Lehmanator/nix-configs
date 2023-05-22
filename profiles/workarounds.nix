{ self, inputs
, config, lib, pkgs
, ...
}:
{
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.0"
  ];
}
