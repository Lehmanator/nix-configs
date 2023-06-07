{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.bustle
    pkgs.d-spy
    pkgs.dbus-map  # TODO: Move to CLI utils
    pkgs.dfeet
    pkgs.sysprof
  ];
}
