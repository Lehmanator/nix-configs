{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "zsh-ls-colors";
  version = "unstable-2022-12-31";

  src = fetchFromGitHub {
    owner = "xPMo";
    repo = "zsh-ls-colors";
    rev = "6a5e0c4d201467cd469b300108939543a59ffed7";
    hash = "sha256-YtzyXVGG5ZfvqIkGSinRx6MxZPaz2NKVkNq7+cvFp7Y=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/xPMo/zsh-ls-colors";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "zsh-ls-colors";
    platforms = platforms.all;
  };
}
