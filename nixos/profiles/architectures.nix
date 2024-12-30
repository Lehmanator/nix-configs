{ inputs, config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    # --- ARM --------------------------

    # --- DOS --------------------------
    pkgs.emu2 # Simple text-mode x86 + DOS emulator

    # --- X86 --------------------------
    pkgs.bochs # IA-32 (x86) PC emulator
    pkgs._86Box # Emulator of x86-based machines based on PCem.

    # --- RISC-V -----------------------
    pkgs.oberon-risc-emu # Emulator for the Oberon RISC machine
    pkgs.tinyemu # System emulator for the RISC-V and x86 architectures
  ];
}
