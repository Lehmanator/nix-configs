{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./iso.nix
  ];

  # TODO: Download Brawl ISO.
  # TODO: Patch Brawl ISO for Project+

  home.packages = [
    pkgs.dolphin-emu
  ];
}
