{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "obsidian-adwaita-theme";
  version = "unstable-2023-12-28";

  src = fetchFromGitHub {
    owner = "birneee";
    repo = "obsidian-adwaita-theme";
    rev = "1d337bf9793caa522b9b241721770fb100ae4e19";
    hash = "sha256-Xok2Fl4h+VpELzfoQ+YiRV0QCHYyXEAUR5USJabiGzQ=";
  };

  meta = with lib; {
    description = "Obsidian theme in the style of Gnome Adwaita";
    homepage = "https://github.com/birneee/obsidian-adwaita-theme";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "obsidian-adwaita-theme";
    platforms = platforms.all;
  };
}
