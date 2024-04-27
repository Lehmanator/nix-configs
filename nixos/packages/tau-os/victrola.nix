{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "victrola";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "victrola";
    rev = "2d6d74f30fbf6519296506ff53f0f185a64f0256";
    hash = "sha256-6HCij6AeAa249lBgElYlff+0f1OQd0OwFeLzjtFZsKE=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/tau-OS/victrola";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "victrola";
    platforms = platforms.all;
  };
}
