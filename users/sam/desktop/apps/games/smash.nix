{ self, inputs,
  config, lib, pkgs,
  ...
}:

# TODO: Auto-patch ISOs for Slippi, UnclePunch Training Modpack, Project M/Project+, Universal Controller Fix
# TODO: Download & install Slippi launcher

{
  imports = [
    #./emulators/nintendo-64.nix
    #./emulators/nintendo-gamecube.nix
    #./emulators/nintendo-wii.nix
    #./emulators/nintendo-wiiu.nix
    #./emulators/nintendo-switch.nix
  ];

  home.packages = [

    # --- Utils ----------------------------------
    pkgs.fd
    pkgs.ffmpeg_6-full

    # --- Chat -----------------------------------
    pkgs.gtkcord
    #pkgs.chatterino

    # --- Emulators ------------------------------
    # TODO: Remove & load ./emulators.nix | ./emulators/nintendo-*.nix
    #pkgs.ryujinx
    #pkgs.yuzu-mainline

    # --- Melee ---------------------------------
    # https://gitlab.com/ramirez7/slippi-netplay-nix
    # https://github.com/UnclePunch/Training-Mode


  ];

  home.shellAliases = {
    ff="ffmpeg -i";
    ff5="ffmpeg -ss 5 -i";
    ff10="ffmpeg -ss 10 -i";
    ff15="ffmpeg -ss 15 -i";
  };
}
