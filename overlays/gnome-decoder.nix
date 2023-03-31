self: super: 
#{ lib
#, fetchFromGitLab
#, libclang
#, rustPlatform
#, meson
#, ninja
#, pkg-config
#, glib
#, gtk4
#, libadwaita
#, zbar
#, sqlite
#, pipewire
#, gstreamer
#, gst-plugins-base
#, gst-plugins-bad
#, wrapGAppsHook4
#, appstream-glib
#, desktop-file-utils
#}:
#let
#  inherit (self) lib;
#  inherit (self.pkgs);
#in
{
gnome-decoder = self.clangStdenv.mkDerivation rec {
  pname = "gnome-decoder";
  version = "0.3.1";

  src = self.fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World";
    repo = "decoder";
    rev = version;
    hash = "sha256-WJIOaYSesvLmOzF1Q6o6aLr4KJanXVaNa+r+2LlpKHQ=";
  };

  cargoDeps = self.rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-RMHVrv/0q42qFUXyd5BSymzx+BxiyqTX0Jzmxnlhyr4=";
  };

  nativeBuildInputs = with self; [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    appstream-glib
    desktop-file-utils
  ] ++ (with rustPlatform; [
    rust.cargo
    rust.rustc
    cargoSetupHook
  ]);

  buildInputs = with self; [
    glib
    gtk4
    libadwaita
    zbar
    sqlite
    pipewire
    gstreamer
    gst-plugins-base
    gst-plugins-bad
  ];

  LIBCLANG_PATH = with self; "${libclang.lib}/lib";

  # FIXME: workaround for Pipewire 0.3.64 deprecated API change, remove when fixed upstream
  # https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/issues/55
  preBuild = ''
    export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
  '';

  #meta = with lib; {
  meta = {
    description = "Scan and Generate QR Codes";
    homepage = "https://gitlab.gnome.org/World/decoder";
    license = self.licenses.gpl3Plus;
    platforms = self.platforms.linux;
    mainProgram = "decoder";
    #maintainers = with self.maintainers; [ zendo ];
    broken = false;
  };
};
}

