{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "zsh-autocomplete";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "marlonrichert";
    repo = "zsh-autocomplete";
    rev = "c7b65508fd3a016dc9cdb410af9ee7806b3f9be1";
    hash = "sha256-u2BnkHZOSGVhcJvhGwHBdeAOVdszye7QZ324xinbELE=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/marlonrichert/zsh-autocomplete";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "zsh-autocomplete";
    platforms = platforms.all;
  };
}
