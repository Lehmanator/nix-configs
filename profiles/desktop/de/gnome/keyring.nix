{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.gnupg.agent.pinentryFlavor = lib.mkDefault "gnome3";
  programs.seahorse.enable = config.services.gnome.gnome-keyring.enable;
  services.gnome.gnome-keyring = {
    enable = true;
  };
}
