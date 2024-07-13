{ config
, lib
, pkgs
, osConfig
, nixosConfig ? {}
, darwinConfig ? {}
, ...
  #, flatpak-repos ? { flathub = "https://flathub.org/repo/flathub.flatpakrepo"; }
}:
let
  os = if (builtins.isAttrs nixosConfig && !(builtins.isAttrs osConfig)) then nixosConfig
    # else if (builtins.isAttrs darwinConfig && !(builtins.isAttrs osConfig)) then darwinConfig
    else if (builtins.isAttrs osConfig) then osConfig
    else {};
  noX11 = (lib.attrsets.attrByPath [ "environment" "noXlibs" ] false os);
  isXwayland = lib.attrsets.attrByPath [ "programs" "xwayland" "enable" ] false os;
  isWayland =
    lib.attrsets.hasAttrByPath [ "services" "xserver" "displayManager" ] os
    && (os.services.xserver.desktopManager.mate.enableWaylandSession
    || os.services.xserver.displayManager.gdm.wayland
    || os.services.xserver.displayManager.qtile.backend == "wayland"
    || os.services.displayManager.sddm.wayland.enable
    || os.programs.hyprland.enable || os.programs.miriway.enable
    || os.programs.river.enable || os.programs.sway.enable
    || os.programs.waybar.enable || os.programs.wayfire.enable
    || os.programs.wshowkeys.enable || os.programs.xwayland.enable);
  #lib.attrsets.recursiveUpdate
in
{
  #(lib.optionalAttrs (options?services.flatpak.packages) {
  #  services.flatpak.remotes = flatpak-repos;
  #  services.flatpak.preInitCommand = "";
  #  services.flatpak.postInitCommand = "";
  #

  # Note: Infinite recursion bug if not imported in lib.nixosSystem ?
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

  #  # TODO: Add all default packages (runtimes, SDKs, themes, libs, plugins, codecs, etc.)
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false;
    remotes = [
      { name = "flathub";       location = "https://dl.flathub.org/repo/flathub.flatpakrepo";        }
      { name = "flathub-beta";  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";    }
    ];
    packages = [ 
      { appId = "com.vscodium.codium"; origin="flathub"; }
    ];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = lib.mkIf isWayland ["wayland" "!x11" "!fallback-x11"];
          # ++ lib.optional isWayland "wayland"
          # ++ lib.optional noX11 "!x11"
          # ++ lib.optional (!isXwayland) "!fallback-x11";

        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = lib.mkIf isWayland "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          #GTK_THEME = "Adwaita:dark";
        };
      };
      "com.vscodium.codium".Context = {
        filesystems = [
          "xdg-config/git:ro"             # Expose user Git config
          "/run/current-system/sw/bin:ro" # Expose NixOS managed software
        ];
        sockets = [
          "gpg-agent" # Expose GPG agent
          "pcsc"      # Expose smart cards (i.e. YubiKey)
        ];
      };
    };
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
  #})
}
