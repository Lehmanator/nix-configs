{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "vscode-adwaita";
  version = "unstable-2023-04-22";

  src = fetchFromGitHub {
    owner = "piousdeer";
    repo = "vscode-adwaita";
    rev = "5de82debcb101e5796b478e55dd382bd64be64f7";
    hash = "sha256-Y2y/osVzgdTajD2DvhFkYk4ZvP7Mi33e5vjCTMTLTGM=";
  };

  meta = with lib; {
    description = "VS Code theme for the GNOME desktop";
    homepage = "https://github.com/piousdeer/vscode-adwaita";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "vscode-adwaita";
    platforms = platforms.all;
  };
}
