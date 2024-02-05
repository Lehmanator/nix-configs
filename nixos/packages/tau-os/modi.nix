{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "tau-os-modi";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "modi";
    rev = "610d164dfe9edafa71d6ec7e855bc345ff9a3b1c";
    hash = "sha256-o/jZ8zjeTBbtvnrGmtQKQ3GY/Bk0v47E6coc2/wj/iw=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "Display pictures";
    homepage = "https://github.com/tau-OS/modi";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "tau-os-modi";
    platforms = platforms.all;
  };
}
