{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "weather-amit9838";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "amit9838";
    repo = "weather";
    rev = "v${version}";
    hash = "sha256-O+nYYXAoAg1lGP8nfG581FcXgnBJbX5D7cEjgZfGUrE=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "Beautiful and lightweight weather app build using Gtk4, Libadwaita and Python";
    homepage = "https://github.com/amit9838/weather";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "weather-amit9838";
    platforms = platforms.all;
  };
}
