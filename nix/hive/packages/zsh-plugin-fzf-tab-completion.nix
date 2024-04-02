{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "fzf-tab-completion";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "lincheney";
    repo = "fzf-tab-completion";
    rev = "9616591b74c72c0f716b214c659b2c3c91964e75";
    hash = "sha256-S/vMAtrQ9GZ9qnK2mEPqfPnpsJBZst4UQDTYxwTkqtI=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/lincheney/fzf-tab-completion";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "fzf-tab-completion";
    platforms = platforms.all;
  };
}
