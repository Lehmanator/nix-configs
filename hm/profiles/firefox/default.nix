{ inputs, osConfig, config, lib, pkgs, ... }:
{
  imports = [
    #./policies.nix

    # --- Profiles ---
    # NOTE: Profiles should load: bookmarks, extensions, search, settings, styles, etc.
    # TODO: `./profiles/gaming.nix`
    # TODO: `./profiles/work.nix`
    # TODO: `./profiles/dev/default.nix`
    # TODO: `./profiles/dev/app.nix`
    # TODO: `./profiles/dev/web.nix`
    ./profiles

    # --- Bookmarks ---
    # TODO: `./bookmarks/cloud.nix`                   # Bookmarks for my cloud services

    # --- Firefox Versions, Releases, & Flavors ---
    #./variants/default.nix                  # Firefox Stable
    ./variants/nightly.nix # Firefox Nightly
    # TODO: `./variants/librewolf.nix`           # Librewolf fork (stable)

    # --- Settings ---
    #./settings/arkenfox.nix                 # Security/privacy enhanced Firefox distro
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.tridactyl-native
      pkgs.gnome-browser-connector
    ];
  };
}
