{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "thunderbird-gnome-theme";
  version = "unstable-2023-12-06";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "thunderbird-gnome-theme";
    rev = "966e9dd54bd2ce9d36d51cd6af8c3bac7a764a68";
    hash = "sha256-K+6oh7+J6RDBFkxphY/pzf0B+q5+IY54ZMKZrFSKXlc=";
  };

  meta = with lib; {
    description = "A GNOME👣 theme for Thunderbird";
    homepage = "https://github.com/rafaelmardojai/thunderbird-gnome-theme";
    license = licenses.unlicense;
    maintainers = with maintainers; [ ];
    mainProgram = "thunderbird-gnome-theme";
    platforms = platforms.all;
  };
}
