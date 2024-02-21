{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "adw-xfwm4";
  version = "unstable-2023-01-24";

  src = fetchFromGitHub {
    owner = "FabianOvrWrt";
    repo = "adw-xfwm4";
    rev = "b0b163bac7d74e5c2d69451d9b1315389bb3c361";
    hash = "sha256-NSpISiwZQ9wt4lHNmA7lluOZiWPd9Dhe4i1iUTqg3Dg=";
  };

  meta = with lib; {
    description = "Libadwaita theme for xfwm4 that follows the default GNOME style emulated by https://github.com/lassekongo83/adw-gtk3";
    homepage = "https://github.com/FabianOvrWrt/adw-xfwm4";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ ];
    mainProgram = "adw-xfwm4";
    platforms = platforms.all;
  };
}
