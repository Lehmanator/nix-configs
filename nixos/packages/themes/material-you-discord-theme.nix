{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "material-you-discord-theme";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "JustAlittleWolf";
    repo = "Material-You-Discord-Theme";
    rev = "main";
    hash = "sha256-xJWev/bul1M23WGUhMP666zNi2hZ9R1pLzhGZwu9S9I=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/JustAlittleWolf/Material-You-Discord-Theme";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "material-you-discord-theme";
    platforms = platforms.all;
  };
}
