{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "nixie";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "nixie";
    rev = "f0016f21a90f3e3370c861aa63e59823de724638";
    hash = "sha256-oel75Wk9/U/fHKNuG8v9Fx6p9gdZwgIYOgHNtobrA5I=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "A Simple Clock App";
    homepage = "https://github.com/tau-OS/nixie";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "nixie";
    platforms = platforms.all;
  };
}
