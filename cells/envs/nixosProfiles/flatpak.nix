{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [inputs.nixos-flatpak.nixosModules.default];

  services.flatpak = {
    enable = true;
    deduplicate = true;

    # Instead of creating a new generation from scratch, try to re-use the old generation, but run `flatpak update` on it.
    #  May significantly reduce bandwidth usage.
    recycle-generation = true;

    # NixOS
    state-dir = "/var/lib/flatpak-module";
    target-dir = "/var/lib/flatpak";

    # Home-Manager
    #state-dir = "${config.xdg.stateHome}/flatpak-module";
    #target-dir = "${config.xdg.dataHome}/flatpak";

    #preInitCommand =
    #postInitCommand =

    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };

    overrides = {
      global = {
        filesystems = [
          "xdg-config:gtk-4.0"
          "xdg-config:gtk-3.0"
          "xdg-config:gtk-2.0"
        ];
        environment = {
          "MOZ_ENABLE_WAYLAND" = 1;
        };
        sockets = [ "!x11" "fallback-x11" ];
      };
    };

    # Packages to install
    #  Format: <remote>:<type>/<flatpak-ref>/<arch>/<branch>:<commit>
    packages = [
      "flathub:app/org.kde.index//stable"
      "flathub-beta:app/org.kde.kdenlive/x86_64/stable"
    ];

  };
}
