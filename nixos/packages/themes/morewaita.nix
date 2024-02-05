{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "morewaita";
  version = "45";

  src = fetchFromGitHub {
    owner = "somepaulo";
    repo = "MoreWaita";
    rev = "v${version}";
    hash = "sha256-UtwigqJjkin53Wg3PU14Rde6V42eKhmP26a3fDpbJ4Y=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "A companion icon theme for Gnome Shell's Adwaita";
    homepage = "https://github.com/somepaulo/MoreWaita";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "morewaita";
    platforms = platforms.all;
  };
}
