{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "theme-spotify-dribbblish-dynamic-theme";
  version = "4.2.2";

  src = fetchFromGitHub {
    owner = "JulienMaille";
    repo = "dribbblish-dynamic-theme";
    rev = version;
    hash = "sha256-70wtFxJOY9h4moT4hCTs4yfp2wGM39i5qnJerBVkpV4=";
  };

  meta = with lib; {
    description = "A mod of Dribbblish theme for Spicetify with support for light/dark modes and album art based colors";
    homepage = "https://github.com/JulienMaille/dribbblish-dynamic-theme";
    changelog = "https://github.com/JulienMaille/dribbblish-dynamic-theme/blob/${src.rev}/CHANGELOG.md";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "theme-spotify-dribbblish-dynamic-theme";
    platforms = platforms.all;
  };
}
