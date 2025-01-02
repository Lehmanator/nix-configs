{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    "${inputs.self}/hm/profiles/flatpak.nix"
    "${inputs.self}/hm/profiles/pipewire.nix"
    "${inputs.self}/hm/profiles/rofi.nix"
    "${inputs.self}/hm/profiles/zed.nix"
    "${inputs.self}/hm/profiles/wayland.nix"
    # "${inputs.self}/hm/profiles/polybar.nix"
    # "${inputs.self}/hm/profiles/udiskie.nix"

    "${inputs.self}/hm/profiles/desktop/fonts.nix"
    # "${inputs.self}/hm/profiles/desktop/fusuma.nix"
    
    # --- Browsers -------------------------------
    (inputs.self + /hm/profiles/chromium.nix)
    # (inputs.self + /hm/profiles/chromium/ungoogled.nix)
    # (inputs.self + /hm/profiles/chromium/chromite.nix)
    # (inputs.self + /hm/profiles/chromium/brave.nix)
    (inputs.self + /hm/profiles/firefox)
    # (inputs.self + /hm/profiles/firefox/arkenfox.nix)
    # (inputs.self + /hm/profiles/firefox/librewolf.nix)
    # (inputs.self + /hm/profiles/firefox/iceraven.nix)
    (inputs.self + /hm/profiles/torbrowser.nix)
  ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};
  #dconf.settings = {
  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  #    binding = "<Shift><Super>b";
  #    command = "browser-chooser";
  #    name = "launch browserchooser";
  #  };
  #};

}
