{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.aviator #               # Merge JSON/YAML files
    pkgs.blackbox-terminal #     # GTK4 terminal application
    pkgs.cambalache #            # Rapid application development for GTK4/GTK3
    pkgs.gitg #                  # Graphical Git client
    pkgs.gnome-builder #         # IDE for developing GNOME apps
    pkgs.gnome-doc-utils #       # Documentation utils
    pkgs.dconf-editor #          # Dconf setting editor
    pkgs.devhelp #               # Developer documentation viewer
    pkgs.ghex #                  # GTK hex editor
    pkgs.zenity #                #

    pkgs.elastic #               # Design spring animations
    pkgs.meld #                  # Visual diff

    #pkgs.pods #                 # Podman desktop application

    # --- Design ---
    pkgs.contrast #              # Check contrast & colorscheme accessibility (WCAG requirements)
    pkgs.emblem #                # Generate project icons & avatars from a symbolic icon
    pkgs.emulsion-palette #      # Store color palettes
    pkgs.eyedropper #            # Color picker & formatter
    pkgs.icon-library #          # Symbolic icon catalog
    pkgs.paleta #                # Generate color paletes
    pkgs.schemes #               # Create / edit syntax highlighting style-schemes for GtkSourceView
    pkgs.symbolic-preview #      # Create, preview, export symbolic icons easily

  ];

  # https://github.com/sonnyp/Commit #           # Edit Git commit messages # TODO: Package
  # https://gitlab.gnome.org/philippun1/turtle # # Git repo Nautilus ext    # TODO: Package
  # https://github.com/fkinoshita/Wildcard #     # Regex tester             # TODO: Package
  # https://github.com/sonnyp/Workbench/ #       # GTK IDE                  # TODO: Package
  # https://gitlab.gnome.org/GNOME/sysprof #     # System profiler          # TODO: Update

}
