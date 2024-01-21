{ lib
, fetchFromGitLab
, runCommand
}:
runCommand "sdm845-alsa-ucm"
{
  src = fetchFromGitLab {
    name = "sdm845-alsa-ucm";
    owner = "sdm845-mainline";
    repo = "alsa-ucm-conf";
    rev = "621c71fd5f5742c60d38766ebb2d1bd3b863a2a4"; # master
    sha256 = "sha256-CgAPg0UUAJUE1gD59l2GNDx3h9crAato6O/dDJpRwiY=";
  };
} ''
  mkdir -p $out/share/
  ln -s $src $out/share/alsa
''
