{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./dbus.nix
    ./developer.nix
    ./phone.nix
    ./productive.nix
    #./office.nix
    #./social.nix
    #./settings

    # TODO: Create ./settings/default.nix
    #./settings/gnome-calculator.nix
  ];

  home.packages = [
  ];

}
