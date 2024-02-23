{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "ad-wave-css";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "ncpa0";
    repo = "ADWaveCSS";
    rev = "d688ab450c54641cac10282c002929b3e6e2a5dc";
    hash = "sha256-UNCsLzMQxs8PKLTvsmQFRtPfEDON7zgBOq3+SOLz7PU=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/ncpa0/ADWaveCSS";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "ad-wave-css";
    platforms = platforms.all;
  };
}
