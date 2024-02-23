{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "spicetify-themes";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";
    rev = "master";
    hash = "sha256-UeHrYgMOB4a7xnl2atAJiNGlvKg8hDyFoaiwNtmQ0Ss=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/spicetify/spicetify-themes";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "spicetify-themes";
    platforms = platforms.all;
  };
}
