{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook4
, cairo
, gdk-pixbuf
, glib
, gtk4
, pango
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "bar-rs";
  version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "elijahimmer";
    repo = "bar-rs";
    rev = "6f682b54f205bee8a070e4c7d661357d8ebce9ba";
    hash = "sha256-8ECsNAQVxHwfcMjjdV3WhWwQEYF2OAYICHl8cqhxavE=";
  };

  cargoHash = "sha256-ZqsAAAB1WBQawShrfKx5ATQ+uX3F15YVvVmg7DP0/yI=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk4
    pango
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.IOKit
  ];

  meta = with lib; {
    description = "A GTK4 status bar made in rust for my desktop";
    homepage = "https://github.com/elijahimmer/bar-rs";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "bar-rs";
  };
}
