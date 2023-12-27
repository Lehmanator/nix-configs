{ lib
, stdenv
, fetchFromGitLab
, gnumake
}:

stdenv.mkDerivation rec {
  pname = "mobile-config-firefox";
  version = "4.0.1";

  src = fetchFromGitLab {
    owner = "postmarketOS";
    repo = "mobile-config-firefox";
    rev = version;
    hash = "sha256-SJirj5OhoZutHth7x5DtQyXNUDvCtFjcpAsn/H8p3+o=";
  };

  buildInputs = [
    gnumake
  ];

  buildPhase = ''
    make all
  '';

  meta = with lib; {
    description = "Mobile and privacy friendly configuration for Firefox (distro-independent";
    homepage = "https://gitlab.com/postmarketOS/mobile-config-firefox/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
  };
}
