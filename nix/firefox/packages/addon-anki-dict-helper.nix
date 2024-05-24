{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "firefox-addon-anki-dict-helper";
  version = "0.99";

  src = fetchFromGitHub {
    owner = "ninja33";
    repo = "anki-dict-helper";
    rev = "v${version}";
    hash = "sha256-xQKNMQz3RMa02d2EDj1VBbKlmnFolG3h3/aAssNPI1A=";
  };

  meta = with lib; {
    description = "Anki划词制卡助手 --  \"划词翻译，一键制卡";
    homepage = "https://github.com/ninja33/anki-dict-helper";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "firefox-addon-anki-dict-helper";
    platforms = platforms.all;
  };
}
