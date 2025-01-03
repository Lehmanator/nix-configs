{ inputs, config, lib, pkgs, osConfig, ... }:
{
  # ./<console>/developer
  # ./<console>/emu/{<emu>,default}.nix
  # ./<console>/homebrew
  # ./<console>/<game>/{iso,<mod>}.nix,default.nix}

  # TODO: Add games to appropriate game launcher app for platform/GUI toolkit
  # - GNOME: Cartridges

  imports = [
    ./chess.nix
    ./clips.nix
    #./controllers
    #./gnome.nix
    #./minecraft.nix
    #./minetest.nix
    ./retroarch.nix
    ./space-cadet-pinball.nix
    #./steam.nix
    #./streaming.nix
    #./unciv.nix

    # --- Nintendo ----------
    ./ns
    ./wiiu
    ./wii
    ./gc
    ./n64
    #./snes
    #./nes
    #./gameboy
    #./gba
    #./ds
    #./3ds

    # --- Sega ---------------
    #./sega-genesis

    # --- Sony ---------------
    #./ps5
    #./ps4
    #./ps3
    #./ps2
    #./ps1
    #./psvita
    #./psp

    # --- Xbox ---------------
    #./xbox-one-x
    #./xbox-one
    #./xbox-360
    #./xbox-orig

    # --- PC -----------------
    #./pc

    # --- Android ------------

    # --- Smash Modding Utils --------------------
    # --- Smash Servers --------------------------

  ];

  home.packages = [
    # --- Emulators: Console -----------
    #pkgs.fceux           # NES
    #pkgs.nestopia        # NES (accuracy focused)
    #pkgs.zsnes           # SNES
    #pkgs.cen64           # N64 (Cycle-Accurate)
  ];
}
