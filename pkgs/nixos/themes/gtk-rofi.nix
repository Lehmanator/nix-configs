{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "gtk-rofi";
  version = "unstable-2022-08-11";

  src = fetchFromGitHub {
    owner = "Git-Fal7";
    repo = "gtk-rofi";
    rev = "6e70b41132203854dfc4ba5f314e60dac87241f5";
    hash = "sha256-uzFd8RgaczNkFp97zwlQx2iiy9u5aVZG/2BFauN7PQ4=";
  };

  meta = with lib; {
    description = "Theme your rofi css using gtk";
    homepage = "https://github.com/Git-Fal7/gtk-rofi";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "gtk-rofi";
    platforms = platforms.all;
  };
}
