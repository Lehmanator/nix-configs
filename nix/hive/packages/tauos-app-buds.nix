{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "buds";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "buds";
    rev = "121acf5919d29c6088986bd257480bab213a7cf6";
    hash = "sha256-/z79x534FtTFfG/7JA9Bg28HQ2jIgGE3R7KSJRAkjNY=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "A contacts app";
    homepage = "https://github.com/tau-OS/buds";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "buds";
    platforms = platforms.all;
  };
}
