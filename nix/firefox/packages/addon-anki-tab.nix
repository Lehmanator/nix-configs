{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "firefox-addon-anki-tab";
  version = "unstable-2020-09-10";

  src = fetchFromGitHub {
    owner = "corollari";
    repo = "ankiTab";
    rev = "b1202bec1e13c888d1f165845e7e52700d4898aa";
    hash = "sha256-aK29TSzzEkLgmuLu0/aBLxH+sFB1SymOTPLQ/DTD4D8=";
  };

  meta = with lib; {
    description = "Browser extension that replaces the new tab page with Anki flashcards";
    homepage = "https://github.com/corollari/ankiTab";
    license = licenses.unlicense;
    maintainers = with maintainers; [ ];
    mainProgram = "firefox-addon-anki-tab";
    platforms = platforms.all;
  };
}
