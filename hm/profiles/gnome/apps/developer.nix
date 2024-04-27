{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./dbus.nix
    #./dev-design.nix
    #./dev-docs.nix
    #./dev-utils.nix
  ];

  home.packages = [
    pkgs.aviator #               # Merge JSON/YAML files
    pkgs.blackbox-terminal #     # GTK4 terminal application
    pkgs.cambalache #            # Rapid application development for GTK4/GTK3
    pkgs.gitg #                  # Graphical Git client
    #pkgs.gnome-builder #         # IDE for developing GNOME apps # Broken 4/14/24
    pkgs.gnome-doc-utils #       # Documentation utils
    pkgs.gnome.dconf-editor #    # Dconf setting editor
    pkgs.gnome.devhelp #         # Developer documentation viewer
    pkgs.gnome.ghex #            # GTK hex editor
    pkgs.gnome.zenity #          #

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
