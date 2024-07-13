{ inputs , config, lib, pkgs , ... }: {
  home.packages = [
    pkgs.lmms                           # DAW similar to FL Studio for music production
    pkgs.fluidsynth                     # Software synth
    pkgs.tenacity                       # Graphical sound editor
    pkgs.nur.repos.mic92.noise-suppression-for-voice
  ];
}
