{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.watchmate  # Companion app for InfiniTime
  ];

}
