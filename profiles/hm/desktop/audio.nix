{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # Note: System audio config in ../../../profiles/desktop/{default,pipewire}.nix
  #  This file is just for user utils that don't get installed for all users by default

  imports = [
    #./audio/alsa.nix
    #./audio/jack.nix
    #./audio/pipewire.nix
    #./audio/pulseaudio.nix
    #./audio/pulseeffects.nix
    ../shell/common/audio.nix # CLI controls for MPRIS & other audio sources

  ];

}


