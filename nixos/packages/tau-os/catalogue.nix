{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "catalogue";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "catalogue";
    rev = "cf4eef7396370c99879a76112c1fd10f88006e2b";
    hash = "sha256-NCZHisVTKclaVbMwl+iWjIO/9jR/g9VpdLW19Gl1JFU=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "An open app store for developers";
    homepage = "https://github.com/tau-OS/catalogue";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "catalogue";
    platforms = platforms.all;
  };
}
