{ self, inputs
, config, lib, pkgs
, ...
}:
# Default apps for GNOME configuration
{
  imports = [
    #./default.nix
    #./epiphany.nix
    ./email.nix
  ];
  environment.systemPackages = [
    pkgs.authenticator          # GTK4 Two-Factor Auth code generator
    pkgs.gnome.gnome-software
  ];

  programs.evince.enable = true;

  services.gnome = {
    core-developer-tools.enable = true;
    core-shell.enable = true;
    core-utilities.enable = true;
    games.enable = true;
    gnome-remote-desktop.enable = true;
    sushi.enable = true;
  };
}
