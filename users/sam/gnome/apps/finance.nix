{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [];

  home.packages = [
    pkgs.denaro         # Personal finance manager GTK4 app
  ];

}
