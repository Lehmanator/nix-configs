{ lib
, stdenv
, fetchFromGitLab
, meson
, ninja
, pkg-config
, rustPlatform
, cairo
, gdk-pixbuf
, glib
, gst_all_1
, gtk4
, gtksourceview5
, libadwaita
, libshumate
, openssl
, pango
, pipewire
, sqlite
, darwin
}:

stdenv.mkDerivation rec {
  pname = "fractal-latest";
  version = "unstable-2023-05-22";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "GNOME";
    repo = "fractal";
    rev = "e881ea90015d72ba097deff68e3135608fac02a9";
    hash = "sha256-w8czOlRiL/2sS4Fw4jrcgRS5YnuTBuThnhCnrPWQOfE=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "matrix-sdk-0.6.2" = "sha256-27FYmqkzqh1wI6B2BI8LM4DoMfymyJdOn5OGsJZjBAc=";
      "ruma-0.8.2" = "sha256-Qsk8KVY5ix7nlDG+1246vQ5HZxgmJmm3KU+RknUFFGg=";
      "vodozemac-0.3.0" = "sha256-tAimsVD8SZmlVybb7HvRffwlNsfb7gLWGCplmwbLIVE=";
      "x25519-dalek-1.2.0" = "sha256-AHjhccCqacu0WMTFyxIret7ghJ2V+8wEAwR5L6Hy1KY=";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    rustPlatform.bindgenHook
    rustPlatform.cargoSetupHook
    rustPlatform.rust.cargo
    rustPlatform.rust.rustc
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
    gtk4
    gtksourceview5
    libadwaita
    libshumate
    openssl
    pango
    pipewire
    sqlite
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
  ];

  meta = with lib; {
    description = "Matrix group messaging app";
    homepage = "https://gitlab.gnome.org/GNOME/fractal";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
  };
}
