{
  inputs,
  cell,
  config,
  lib,
  pkgs,
  ...
}:
# https://nixos.wiki/wiki/Fonts
#
# ln -s /run/current-system/sw/share/X11/fonts ~/.local/share/fonts
# - TODO: Similar to ^, but for home-manager?
{
  system.fsPackages = [pkgs.bindfs];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
    };
    allIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = [
        pkgs.gnome.gnome-themes-extra
        pkgs.hicolor-icon-theme
        pkgs.cosmic-icons

        #pkgs.icon-library
        pkgs.tela-icon-theme
        pkgs.qogir-icon-theme
        #pkgs.papirus-maia-icon-theme
        pkgs.papirus-icon-theme
        pkgs.dracula-icon-theme
        pkgs.vimix-icon-theme
        pkgs.tela-icon-theme
      ];
      pathsToLink = ["/share/icons"];
    };
    allFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = ["/share/fonts"];
    };
    # TODO: Figure out how to let home-manager merge with this.
  in {
    "/usr/share/icons" = mkRoSymBind "${allIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${allFonts}/share/fonts";
  };

  fonts = {
    fontDir.enable = true;
    packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.noto-fonts-cjk
      pkgs.liberation_ttf
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.mplus-outline-fonts.githubRelease
      pkgs.dina-font
      pkgs.proggyfonts

      pkgs.nerdfonts
      #(pkgs.nerdfonts.override {fonts=["FiraCode" "DroidSansMono"];})
      #pkgs.terminus-nerdfont
      #pkgs.inconsolata-nerdfont
      #pkgs.fira-code-nerdfont
    ];
  };
}
