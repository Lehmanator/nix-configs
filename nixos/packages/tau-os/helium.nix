{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "tau-helium";
  version = "1.5.22";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "tau-helium";
    rev = version;
    hash = "sha256-2H5qLy7WCtwxsaNflNLNPz3rNMrOvwkMSeqnH6Y3F2Q=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "The GTK/GNOME Shell theme for tauOS";
    homepage = "https://github.com/tau-OS/tau-helium";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "tau-helium";
    platforms = platforms.all;
  };
}
