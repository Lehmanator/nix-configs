{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "adwaita-for-steam";
  version = "1.16";

  src = fetchFromGitHub {
    owner = "tkashkin";
    repo = "Adwaita-for-Steam";
    rev = "v${version}";
    hash = "sha256-oSd/Qv+T3d/3sdNSV8cLPUmzmqYQiCFEHelY0Ku5ftA=";
  };

  meta = with lib; {
    description = "A skin to make Steam look more like a native GNOME app";
    homepage = "https://github.com/tkashkin/Adwaita-for-Steam";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "adwaita-for-steam";
    platforms = platforms.all;
  };
}
