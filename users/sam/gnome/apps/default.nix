{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./dbus.nix
    ./developer.nix
    ./multimedia.nix
    ./phone.nix
    ./productive.nix
    #./office.nix
    ./security.nix
    #./settings
    #./social.nix


    # --- Individual Apps ---
    ./gnome-calculator.nix
    ./vaults.nix

  ];

  home.packages = [
    pkgs.tangram          # Launcher/browser for web apps
  ];

}
