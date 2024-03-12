{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.mic92.noise-suppression-for-voice
    pkgs.nur.repos.timsueberkrueb.lmms  # DAW similar to FL Studio for music production
    pkgs.nur.repos.tinybeachthor.fluidsynth # Software synth
    pkgs.tenacity                       # Graphical sound editor
  ];

}
