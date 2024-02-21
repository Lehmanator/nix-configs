{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "kairos";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "kairos";
    rev = "90dd88dbe5802c357669216a573c59152fbb1da9";
    hash = "sha256-7r55Wol1cwo/l41Abe/MOX10uiKgeX5FBUMEDLU4lY0=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/tau-OS/kairos";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "kairos";
    platforms = platforms.all;
  };
}
