{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "gtk4-eink";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "MichiMolle";
    repo = "gtk4-eink";
    rev = "main";
    hash = "sha256-i60eWEUgCUmGgIcF46rfqv+JUrhz7zDoLqdhE+HbZk8=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/MichiMolle/gtk4-eink";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "gtk4-eink";
    platforms = platforms.all;
  };
}
