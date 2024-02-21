{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "adw-gtk3";
  version = "5.2";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = "adw-gtk3";
    rev = "v${version}";
    hash = "sha256-S6Yo67DTyRzS9uz/6g87SRmfPIBmAKfy4c23M5aENNg=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "The theme from libadwaita ported to GTK-3";
    homepage = "https://github.com/lassekongo83/adw-gtk3";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ ];
    mainProgram = "adw-gtk3";
    platforms = platforms.all;
  };
}
