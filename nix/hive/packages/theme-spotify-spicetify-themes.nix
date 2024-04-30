{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "theme-spotify-spicetify-themes";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";
    rev = version;
    hash = "sha256-qii6iRU7ZaHTT8DuRwhSt8y/K/41ElltLZvmc/1dRpQ=";
  };

  meta = with lib; {
    description = "A community-driven collection of themes for customizing Spotify through Spicetify - https://github.com/spicetify/spicetify-cli";
    homepage = "https://github.com/spicetify/spicetify-themes";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "theme-spotify-spicetify-themes";
    platforms = platforms.all;
  };
}
