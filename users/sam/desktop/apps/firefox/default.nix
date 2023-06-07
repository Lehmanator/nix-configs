{
  self,
  modulesPath,
  inputs, outputs,
  host, network, repo,
  config, lib, pkgs,
  ...
}:
{
  imports = [
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
    ./variants/nightly.nix                  # Firefox Nightly
    # TODO: `./variants/librewolf.nix`           # Librewolf fork (stable)

    # --- Settings ---
    #./settings/arkenfox.nix                 # Security/privacy enhanced Firefox distro
  ];

  programs.firefox.enable = true;

  #programs.firefox.enableGnomeExtensions = true;
  programs.firefox.package = pkgs.firefox.override {
    cfg.enableGnomeExtensions = config.gtk.enable;  #config.services.xserver.desktopManager.gnome.enable;
    cfg.enableTridactylNative = true;
  };
}
