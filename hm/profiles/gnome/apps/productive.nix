{ self
, inputs
, config
, pkgs
, lib
, ...
}:
{
  imports = [ ];

  home.packages = [
    pkgs.endeavour #   # To-do manager (https://gitlab.gnome.org/World/Endeavour)
    pkgs.formiko #     # reStructuredText editor & live preview
    pkgs.furtherance # # https://github.com/lakoliu/Furtherance
    #pkgs.gaphor #      # Simple modeling tool (broken as of 1/15/23: failing version check for dep jedi-0.19.1)
    pkgs.gnome-solanum # Pomodoro timer
    #pkgs.khronos #     # https://github.com/lainsce/khronos
    pkgs.rnote #       # Handwritten Notes (https://github.com/flxzt/rnote)
    pkgs.sticky #      # Sticky Notes      (https://github.com/linuxmint/sticky)

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
    iplan
    #passes
    #phosh-osk-stub
    #pipeline
    #purism-stream
    #telegrand
  ]);

  services.flatpak.packages = [
    "flathub:app/com.mardojai.DiccionarioLengua//stable" # DiccionarioLengua
    "flathub:app/dev.edfloreshz.Done//stable" #             # Done         (https://github.com/done-devs/done)
    "flathub:app/io.github.mrvladus.List//stable" #         # Errands      (https://github.com/mrvladus/List)
    "flathub:app/io.github.dgsasha.Remembrance//stable" #   # Reminders    (https://github.com/dgsasha/remembrance)
    "flathub-beta:app/io.github.dgsasha.Remembrance//beta"
    "flathub:app/com.github.alainm23.planner//stable" #     # Plannner     (https://github.com/alainm23/planner)
    "flathub:app/io.github.zhrexl.thisweekinmylife//stable" # ThisWeekInMyLife (https://github.com/zhrexl/ThisWeekInMyLife)
    "flathub:app/io.github.kaschpal.timetable//stable" #    # Timetable    ()
    "flathub:app/codes.loers.Punchclock//stable" #          # Punchclock   (https://gitlab.com/floers/punchclock)
    "flathub:app/com.vixalien.sticky//stable" #             # Sticky Notes (https://gitlab.com/vixalien/sticky)
    # - vNotes

    # --- Diagrams ---
    "flathub:app/org.gaphor.Gaphor//stable"

    # --- Health ---
    "flathub:app/io.github.diegopvlk.Dosage//stable" #      # Dosage ()
    "flathub:app/xyz.slothlife.Jogger//stable" #            # Jogger (https://codeberg.org/baarkerlounger/jogger)

  ];

  # https://gitlab.gnome.org/GNOME/gnome-calendar/ #                # Calendar app        TODO: Update
  # https://github.com/Diego-Ivan/Flowtime #                        # Time tracker        TODO: Update
  # https://gitlab.gnome.org/World/apostrophe #                     # Markdown editor     TODO: Update
  # https://apps.gnome.org/PdfMetadataEditor/ #                     # Edit PDF metadata   TODO: Package

}
