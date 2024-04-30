{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "accelerator";
  version = "unstable-2024-01-31";

  src = fetchFromGitHub {
    owner = "tau-OS";
    repo = "accelerator";
    rev = "28bea0417302e6f28248ed040d89f75fdd1b83cf";
    hash = "sha256-TnjhjZc4hiHktBUmhrg1nvjMse0sduS3uas0f7dx6Z4=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "Terminal editor for tauOS";
    homepage = "https://github.com/tau-OS/accelerator";
    changelog = "https://github.com/tau-OS/accelerator/blob/${src.rev}/CHANGELOG.md";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "accelerator";
    platforms = platforms.all;
  };
}
