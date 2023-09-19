{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./chess.nix

    # TODO: Load smash from emulators.nix OR load emulators from smash.nix?
    # TODO: Create ./emulators/default.nix
    # TODO: Create ./emulators/nintendo-{gameboy{,color,advance},nes,snes,64,ds,3ds,wii,wiiu,switch}.nix
    # TODO: Create ./emulators/ps{p,1,2,3,4,5}.nix
    # TODO: Create ./emulators/sega-{genesis}.nix
    # TODO: Create ./emulators/xbox{,360,one,onex}.nix
    ./emulators.nix

    # TODO: Create ./smash/default.nix
    # TODO: Create ./smash/modding.nix
    # TODO: Create ./smash/servers.nix
    # TODO: Create ./smash/utils.nix
    ./smash.nix
    #./smash-modding.nix

    # TODO: Create ./steam.nix
  ];

  home.packages = [
    pkgs.nur.repos.xddxdd.space-cadet-pinball-full-tilt

    #pkgs.goldberg-emu     # Program that emulates steam online features TODO: Move to ./steam.nix
  ];

}
