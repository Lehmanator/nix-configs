{ buildNpmPackage, lib, stdenv, fetchFromGitHub, }:
buildNpmPackage rec {
  pname = "aw-webui";
  version = "unstable-2024-01-08";

  src = fetchFromGitHub {
    owner = "ActivityWatch";
    repo = "aw-webui";
    rev = "23df3fba023b0386749ca9518d8518d2878e31ae";
    hash = "sha256-gRgJSPl8vyojxf2FAVMuQ9EE6C2VvGuF9SoT27wy3Uc=";
    fetchSubmodules = true;
  };

  npmDepsHash = "sha256-Ewc2C0MUlKYFMIAKn6qhSKXL0s+KN0aVLGquVxpNzwc=";
  #npmPackFlags = ["--ignore-scripts"];

  installPhase = ''
    runHook preInstall
    mv dist $out
    cp media/logo/logo.{png,svg} $out/static/
    runHook postInstall
  '';
  doCheck = true;
  checkPhase = ''
    runHook preCheck
    npm test
    runHook postCheck
  '';

  meta = with lib; {
    description =
      "Webapp for visualizing and browsing ActivityWatch data, built with Vue.js";
    homepage = "https://github.com/ActivityWatch/aw-webui";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    mainProgram = "aw-webui";
    platforms = platforms.all;
  };
}
