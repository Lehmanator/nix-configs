{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "adw-colors";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = "adw-colors";
    rev = "336a5697c36995219217546fd0427a0eea705959";
    hash = "sha256-r/y8MqVlnlnvWsVKZDb0Xl6W6tMqmWVXpg3bKFiQYFI=";
  };

  meta = with lib; {
    description = "Style libadwaita & adw-gtk3 with named colors";
    homepage = "https://github.com/lassekongo83/adw-colors";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "adw-colors";
    platforms = platforms.all;
  };
}
