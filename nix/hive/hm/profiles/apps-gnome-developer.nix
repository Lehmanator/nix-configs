{ inputs
, config, lib, pkgs
, ...
}:
let
  prefer-flatpak = false;
  prefer-native = ! prefer-flatpak;
in
{
  # TODO: Split into dev-generic, dev-gnome, dev-desktop, dev-mobile, dev-web, dev-desktop-designer,
  # TODO: Rename to role-developer.nix
  # TODO: Conditionally enable appropriate apps for TUIs/CLIs, GNOME, KDE, ...
  home.packages = [

    pkgs.gnome-doc-utils #       # Documentation utils
    pkgs.gnome.dconf-editor #    # Dconf setting editor
    pkgs.gnome.devhelp #         # Developer documentation viewer
    pkgs.gnome.zenity #          #

    # --- Design ---
    pkgs.contrast #              # Check contrast & colorscheme accessibility (WCAG requirements)
    pkgs.emblem #                # Generate project icons & avatars from a symbolic icon
    pkgs.emulsion-palette #      # Store color palettes
    pkgs.eyedropper #            # Color picker & formatter
    pkgs.icon-library #          # Symbolic icon catalog
    pkgs.paleta #                # Generate color paletes
    pkgs.symbolic-preview #      # Create, preview, export symbolic icons easily
  ] ++ lib.optionals prefer-native [
    # --- Design ---
    pkgs.cambalache #            # Rapid application development for GTK4/GTK3
    pkgs.elastic #               # Design spring animations
    pkgs.schemes #               # Create / edit syntax highlighting style-schemes for GtkSourceView

    # --- Dev ---
    pkgs.blackbox-terminal #     # GTK4 terminal application
    pkgs.commit #                # Commit message editor
    pkgs.d-spy #                 # D-Bus explorer
    pkgs.gnome.ghex #            # GTK hex editor
    pkgs.gitg #                  # Graphical Git client
    pkgs.gnome-builder #         # IDE for developing GNOME apps
    pkgs.meld #                  # Visual diff
    pkgs.pods #                  # Podman desktop application
    pkgs.ptyxis #                # GTK4 Terminal w/ first-class container support
    pkgs.sysprof #               # System-wide profiler
    pkgs.turtle #                # Git repo Nautilus ext # TODO: `sudo python install.py install --flatpak`
    pkgs.wildcard #              # Regex tester
  ];

  services.flatpak.packages = lib.mkIf prefer-flatpak [
    "org.gnome.Builder"        # GNOME/GTK IDE
    "org.gnome.dspy"           # D-Bus explorer
    "org.gnome.GHex"           # Binary hex editor
    "org.gnome.gitg"           # Git graphical client
    "org.gnome.meld"           # Diff compare & merge app
    "org.gnome.Ptyxis"         # Terminal
    "org.gnome.Sysprof"        # System profiler
    #   - [ ] TODO: NixOS option: services.sysprof.enable = true
    "com.github.marhkb.Pods"   # Podman container manager app
    "com.raggesilver.BlackBox" # GTK4 Terminal
    "de.philippun1.turtle"     # Git repo Nautilus ext
    "re.sonny.Commit"          # Commit message editor
    "re.sonny.Workbench"       # GTK IDE
    "com.felipekinoshita.Wildcard" # Regex tester

    # --- Design ---
    "app.devsuite.Schemes"     # Create syntax highlighting color schemes
    "app.drey.Elastic"         # Design spring animations
    "ar.xjuan.Cambalache"      # UI Designer
  ];
}
