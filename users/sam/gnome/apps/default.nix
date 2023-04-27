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


    # --- Individual Apps ---
    ./gnome-calculator.nix
    ./vaults.nix

  ];

  home.packages = [
  ];

}
