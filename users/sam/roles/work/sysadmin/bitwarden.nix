{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  home.packages = [ pkgs.bitwarden ];

  programs.rbw = {
    enable = true;
    settings.email = "slehman@piwine.com";
    pinentry = lib.mkIf config.services.gnome-keyring.enable "gnome3";
  };

}
