{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "firefox-sidebar";
  version = "2022.11.29";

  src = fetchFromGitHub {
    owner = "drannex42";
    repo = "FirefoxSidebar";
    rev = "v1${version}";
    hash = "sha256-ARdlL6Wp4kbGzHsX1SCXa7gltgo0b3L94s6QLO93E7k=";
  };

  meta = with lib; {
    description = "Vertical tab design for Firefox with dynamic indentation:: Sideberry and TreeStyleTabs (Legacy) themes available";
    homepage = "https://github.com/drannex42/FirefoxSidebar";
    changelog = "https://github.com/drannex42/FirefoxSidebar/blob/${src.rev}/changelog.md";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "firefox-sidebar";
    platforms = platforms.all;
  };
}
