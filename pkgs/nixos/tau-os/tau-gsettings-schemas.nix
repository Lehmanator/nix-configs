{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "tau-gsettings-schemas";
  version = "unstable-2024-01-30";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "tau-gsettings-schemas";
    rev = "51153688709c59f429d819d3af3e229fbc528f7e";
    hash = "sha256-SsgA7Ms8HE2cE0EEsR9JHJvT78xqErzYyVOjN3gwCZo=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/tau-OS/tau-gsettings-schemas";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "tau-gsettings-schemas";
    platforms = platforms.all;
  };
}
