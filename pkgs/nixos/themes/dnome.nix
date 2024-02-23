{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "dnome";
  version = "unstable-2023-11-13";

  src = fetchFromGitHub {
    owner = "GeopJr";
    repo = "DNOME";
    rev = "2eabeaa4d49ed08f95a4ae697276a0327f3c2b3c";
    hash = "sha256-bfzDeky8t/sZcQKse+0dbXaH7zthBJlA+Pju7DmcZyE=";
  };

  meta = with lib; {
    description = "Adwaita-inspired Discord Theme";
    homepage = "https://github.com/GeopJr/DNOME";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ];
    mainProgram = "dnome";
    platforms = platforms.all;
  };
}
