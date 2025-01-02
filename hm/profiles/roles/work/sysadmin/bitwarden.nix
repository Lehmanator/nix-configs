{ inputs, config, lib, pkgs, ... }:
{
  imports = [(inputs.self + /hm/profiles/bitwarden.nix)];
  programs.rbw = {
    enable = true;
    settings.email = "slehman@piwine.com";
    pinentry = lib.mkIf config.services.gnome-keyring.enable "gnome3";
  };
}
