{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "dosage";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "diegopvlk";
    repo = "Dosage";
    rev = "169c8870df4ddba0658c4f48f14acc81722ad045";
    hash = "sha256-j8ItpmfESK23d1tgujdOYvvF5jK5gYiG60LKeJ7vtUQ=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/diegopvlk/Dosage";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "dosage";
    platforms = platforms.all;
  };
}
