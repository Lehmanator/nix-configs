{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "enigma";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "enigma";
    rev = "91b7d89cda46b4cf30afcb790c0c202415df7592";
    hash = "sha256-4yPxS8F/UhiLSiNzte1R9Tmt6s3iP7fHpDOB46ThWC4=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/tau-OS/enigma";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "enigma";
    platforms = platforms.all;
  };
}
