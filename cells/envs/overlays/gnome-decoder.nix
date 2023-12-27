# gnome-decoder: fixed version already in NixOS/nixpkgs:master
#   TODO: Remove when fix hits NixOS/nixpkgs:nixos-unstable
final: prev: {
  gnome-decoder = prev.gnome-decoder.overrideAttrs (
    attrs: {
      preBuild = ''
	export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
      '';
      meta.broken = false;
    }
  );
}
