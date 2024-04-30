{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "errands";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "Errands";
    rev = "main";
    hash = "sha256-jREIr1pnGmjFyJ/azeJ3VN4tFRp5xoikEMrGKzL9ros=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/rafaelmardojai/Errands";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "errands";
    platforms = platforms.all;
  };
}
