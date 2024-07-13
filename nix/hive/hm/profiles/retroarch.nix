{ config, lib, pkgs, ... }: {
  home.packages = [
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/emulators/retroarch/cores.nix
    pkgs.retroarch-assets # Assets for RetroArch
    pkgs.retroarchFull # Multi-platform emulator frontend for libretro cores (all cores) [retroarch{,Full,Bare)
    pkgs.retro-gtk # GTK frontend to libretro cores  # TODO: Move to GTK/GNOME profile?
    pkgs.retroarch-joypad-autoconfig
    pkgs.libretro.thepowdertoy # Example core (The Powder Toy)
    pkgs.libretro.vba-next
    pkgs.libretro.twenty-fortyeight

    # --- Atari ----------------------------------
    #pkgs.hatari          # Atari ST/STE/TT/Falcon
    #pkgs.stella          # Atari 2600 VCS

    # --- Nintendo -------------------------------
    # --- Handheld ---
    #pkgs.sameboy         # GameBoy, GameBoy Color, & Super GameBoy
    #pkgs.gambatte        # GameBoy Color (Portable)
    #pkgs.mgba            # GBA (accuracy focused)
    #pkgs.desmume         # Nintendo DS
    #pkgs.melonDS         # Nintendo DS (WIP)

    # --- Console ---
    #pkgs.fceux           # NES
    #pkgs.nestopia        # NES (accuracy focused)
    #pkgs.zsnes           # SNES
    #pkgs.cen64           # N64 (Cycle-Accurate)
    #pkgs.dolphin-emu # Gamecube / Wii emulator for x86_64 & ARMv8
    # pkgs.cemu # Wii U                                          #pkgs.nur.repos.mcaju.decaf-emu
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev

    # --- Playstation ----------------------------
    #pkgs.pcsxr           # PS1
    #pkgs.pcsx2           # PS2
    #pkgs.rpcs3           # PS3

    # --- Sega -----------------------------------
    #pkgs.dgen-sdl        # Sega Genesis/Mega Drive emulator
    #pkgs.gensgs          # Sega Genesis
    #pkgs.yabause         # Sega Saturn

    # --- Xbox -----------------------------------
    #pkgs.xemu            # Original Xbox emulator
  ];
  services.flatpak.packages = [{ appId = "org.libretro.RetroArch"; }]
    ++ lib.optional config.programs.gnome-shell.enable {
    appId = "page.kramo.Cartridges";
  };
}
