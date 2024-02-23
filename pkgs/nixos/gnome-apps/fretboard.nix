{ lib
, stdenv
, fetchFromGitHub
, cargo
, meson
, ninja
, pkg-config
, rustPlatform
, rustc
, wrapGAppsHook4
, cairo
, gdk-pixbuf
, glib
, gtk4
, libadwaita
, pango
}:

stdenv.mkDerivation rec {
  pname = "fretboard";
  version = "5.3";

  src = fetchFromGitHub {
    owner = "bragefuglseth";
    repo = "fretboard";
    rev = "v${version}";
    hash = "sha256-wwq4Xq6IVLF2hICk9HfCpfxpWer8PNWywD8p3wQdp6U=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-H/dAKaYHxRmldny8EoasrcDROZhLo5UbHPAoMicDehA=";
  };

  nativeBuildInputs = [
    cargo
    meson
    ninja
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    wrapGAppsHook4
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    pango
  ];

  meta = with lib; {
    description = "Look up guitar chords";
    homepage = "https://github.com/bragefuglseth/fretboard";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "fretboard";
    platforms = platforms.all;
  };
}
