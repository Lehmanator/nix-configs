{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Slippi
  # sudo rm -f /etc/udev/rules.d/51-gcadapter.rules && sudo touch /etc/udev/rules.d/51-gcadapter.rules && echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null && sudo udevadm control --reload-rules

  home.packages = [
    pkgs.libGLU
    pkgs.libopenglrecorder
    pkgs.fuse
    pkgs.fuse3
    pkgs.fuse-common
    pkgs.qgnomeplatform-qt6
    pkgs.qt6.full
    pkgs.qt6Packages.qt6gtk2


    # --- Multi-Platform -------------------------
    pkgs.appimagekit
    pkgs.appimage-run

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
    pkgs.cemu # Wii U                                          #pkgs.nur.repos.mcaju.decaf-emu
    pkgs.ryujinx # Nintendo Switch                                #pkgs.nur.repos.ivar.ryujinx
    pkgs.yuzu-early-access # Nintendo Switch (experimental preview version) #pkgs.nur.repos.ivar.yuzu-ea
    #pkgs.yuzu-mainline   # Nintendo Switch (mainline branch version)      #pkgs.nur.repos.ivar.yuzu-mainline
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
}
