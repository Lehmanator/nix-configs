{ inputs, config, lib, pkgs, ... }:
{
  imports = [
  ];

  # --- ISOs -------------------------------------------------
  # TODO: Auto-patch Melee ISOs for Slippi:
  # - UnclePunch Training Modpack
  # - Universal Controller Fix

  # TODO: Auto-patch Brawl ISO:
  # - Project M/Project+

  # Gamecube / Wii emulator for x86_64 & ARMv8
  home.packages = [ pkgs.dolphin-emu ];

}
