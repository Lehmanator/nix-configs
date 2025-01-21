{ inputs, config, lib, pkgs, ... }:
{
  # --- Phosh Desktop -----------------------------------------------
  imports = [
    (inputs.self + /nixos/profiles/gtk.nix)
    (inputs.self + /nixos/profiles/flatpak.nix)
    (inputs.self + /nixos/profiles/pipewire.nix)
    (inputs.self + /nixos/profiles/wayland.nix)
  ];

  services.desktopManager.phosh = {
    enable = true;
    package = pkgs.phosh;

    # group = "users";
    # user = lib.mkDefault "nixos";

    # Config for the Phoc compositor: /etc/phosh/phoc.ini
    phocConfig = {
      xwayland = "true";
      cursorTheme = "default";
      outputs = {
        e-DP1 = {
          mode = "2256x1504";
          modelines = [];
          scale = 1.0;
          rotate = null;
        };
      };
    };
  };

  environment.systemPackages = [
    pkgs.phosh-mobile-settings
    pkgs.mepo
  ];

}
