{ lib
, cmake
, fetchFromGitLab
, glib
, gobject-introspection
, json-glib
, meson
, ninja
, pkg-config
, stdenv
, ...
}:
stdenv.mkDerivation {
  pname = "walbottle";
  version = "0.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "walbottle";
    repo = "Walbottle";
    rev = "e643df32f84d04b42964bc1e605cd8b01bff5d79";
    hash = "sha256-K+qhfyYB/yQURSUoNSptOMeS4FIy4ZMtTiAl0OF2DPY=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ cmake glib json-glib gobject-introspection ];
  # pkgConfigModules = [ "libwalbottle-0" ];

  meta = {
    homepage = "https://gitlab.com/walbottle/walbottle";
    description = "Walbottle is a project for generating JSON unit test vectors from JSON Schemas.";
    longDescription = "Walbottle is a project for generating JSON unit test vectors from JSON Schemas.\nIt provides a library, libwalbottle, which implements JSON Schema parsing and test vector generation.";
    license = lib.licenses.lgpl21;
    mainProgram = "json-validate";
    outputsToInstall = ["out" "lib"];
    
  };
}
