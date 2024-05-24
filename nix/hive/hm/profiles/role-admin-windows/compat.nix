{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    # --- Compat Layers ---
    # TODO: WINE & Bottles
    pkgs.msbuild # Mono version of Microsoft Build Engine, the build platform for .NET, and Visual Studio
    pkgs.playonlinux # GUI for managing Windows programs under linux
    pkgs.proton-caller # Run Windows programs with Proton
    pkgs.wibo # Quick-and-dirty wrapper to run 32-bit windows EXEs on linux
  ];
}
