{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "nix-flake-schemas";
  version = "flake-schemas-2024-03-11";

  src = fetchFromGitHub {
    owner = "NixOS";
    repo = "nix";
    rev = "d76e5fb297eec5163dacf1346b2fc07562526386";
    hash = "sha256-MFW7NoTvbT2ckIPJQTHhMnRn1s3Ay+aAUVkL1GJPsuY=";
  };

  meta = with lib; {
    description = "Nix, the purely functional package manager";
    homepage = "https://github.com/NixOS/nix";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ ];
    mainProgram = "nix-flake-schemas";
    platforms = platforms.all;
  };
}
