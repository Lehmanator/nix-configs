{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "aqui";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "aqui";
    rev = "272996504ea6fe570a032c3123f7934695ad53a4";
    hash = "sha256-W9w7UeabWo4iDIS3ynMJ+UEzuK/NrSmJ2QyIpFJxIv0=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "View where to go";
    homepage = "https://github.com/tau-OS/aqui";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "aqui";
    platforms = platforms.all;
  };
}
