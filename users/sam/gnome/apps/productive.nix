{ self, inputs,
  config, pkgs, lib,
  ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.endeavour    # https://gitlab.gnome.org/World/Endeavour
    pkgs.furtherance  # https://github.com/lakoliu/Furtherance
    pkgs.khronos      # https://github.com/lainsce/khronos
    pkgs.paper-note   # https://gitlab.com/posidon_software/paper
    pkgs.rnote        # https://github.com/flxzt/rnote

    # --- Broken Apps ---
    #pkgs.notejot      # https://github.com/lainsce/notejot

    # --- Unused Apps ---
    #pkgs.gnomeExtensions.notes   #
    #pkgs.gtg                     # https://github.com/getting-things-gnome/gtg
    #pkgs.sticky                  # https://github.com/linuxmint/sticky

  ];

  # --- Unavailable Apps ---
  # Use flatpak
  # - List             (https://github.com/mrvladus/List)
  # - Plannner         (https://github.com/alainm23/planner)
  # - Punchclock       (https://gitlab.com/floers/punchclock)
  # - Sticky Notes     (https://github.com/vixalien/sticky)
  # - ThisWeekInMyLife (https://github.com/zhrexl/ThisWeekInMyLife)
  # - vNotes
  #
}
