{ inputs, config, pkgs, lib, ... }: {
  home.packages = [
    pkgs.endeavour #    # To-do manager (https://gitlab.gnome.org/World/Endeavour)
    pkgs.formiko #      # reStructuredText editor & live preview
    pkgs.furtherance #  # https://github.com/lakoliu/Furtherance
    #pkgs.gaphor #      # Simple modeling tool (broken as of 1/15/23: failing version check for dep jedi-0.19.1)
    pkgs.gnome-solanum ## Pomodoro timer
    #pkgs.khronos #     # https://github.com/lainsce/khronos
    pkgs.rnote #        # Handwritten Notes (https://github.com/flxzt/rnote)
    pkgs.sticky #       # Sticky Notes      (https://github.com/linuxmint/sticky)

    # --- Broken Apps ---
    #pkgs.notejot #    # https://github.com/lainsce/notejot
    #pkgs.paper-note # # https://gitlab.com/posidon_software/paper  (abandoned)

    # --- Unused Apps ---
    #pkgs.gnomeExtensions.notes # #
    #pkgs.gtg #                   # https://github.com/getting-things-gnome/gtg

  ] ++ (with inputs.nixpkgs-gnome-apps.packages.${pkgs.system}; [
    #avvie
    #bunker
    flashcards
    #gadgetcontroller
    #iplan
    #passes
    #phosh-osk-stub
    #pipeline
    #purism-stream
    #telegrand
  ]);

  services.flatpak.packages = [
    "ir.imansalmani.IPlan" #            # IPlan        (https://github.com/)
    "com.mardojai.DiccionarioLengua" #  # DiccionarioLengua
    "dev.edfloreshz.Done" #             # Done         (https://github.com/done-devs/done)
    "io.github.mrvladus.List" #         # Errands      (https://github.com/mrvladus/List)
    "io.github.dgsasha.Remembrance" #   # Reminders    (https://github.com/dgsasha/remembrance)
    "com.github.alainm23.planner" #     # Plannner     (https://github.com/alainm23/planner)
    "io.github.zhrexl.thisweekinmylife" # ThisWeekInMyLife (https://github.com/zhrexl/ThisWeekInMyLife)
    "io.github.kaschpal.timetable" #    # Timetable    ()
    "codes.loers.Punchclock" #          # Punchclock   (https://gitlab.com/floers/punchclock)
    "com.vixalien.sticky" #             # Sticky Notes (https://gitlab.com/vixalien/sticky)
    # - vNotes

    # --- Diagrams ---
    "org.gaphor.Gaphor"

    # --- Health ---
    "io.github.diegopvlk.Dosage" #      # Dosage ()
    "xyz.slothlife.Jogger" #            # Jogger (https://codeberg.org/baarkerlounger/jogger)

  ];

  # https://gitlab.gnome.org/GNOME/gnome-calendar/ #                # Calendar app        TODO: Update
  # https://github.com/Diego-Ivan/Flowtime #                        # Time tracker        TODO: Update
  # https://gitlab.gnome.org/World/apostrophe #                     # Markdown editor     TODO: Update
  # https://apps.gnome.org/PdfMetadataEditor/ #                     # Edit PDF metadata   TODO: Package

}
