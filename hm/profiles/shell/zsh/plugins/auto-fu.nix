{
  pkgs,
  lib,
  ...
}:
# https://github.com/hchbaw/auto-fu.zsh
# TODO: Last update upstream was in 2013. Consider better-maintained alternatives.
{
  name = "auto-fu";
  file = "auto-fu.zsh";
  src = pkgs.fetchFromGitHub {
    owner = "hchbaw";
    repo = "auto-fu.zsh";
    rev = "0ab1af41ec5eea2a1c324c4aba180a2b39426bba";
    hash = lib.fakeHash;
  };
}
