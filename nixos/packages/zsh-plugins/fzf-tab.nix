{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "zsh-fzf-tab";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "b06e7574577cd729c629419a62029d31d0565a7a";
    hash = "sha256-ilUavAIWmLiMh2PumtErMCpOcR71ZMlQkKhVOTDdHZw=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/Aloxaf/fzf-tab";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "zsh-fzf-tab";
    platforms = platforms.all;
  };
}
