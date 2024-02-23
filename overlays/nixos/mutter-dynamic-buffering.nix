# TODO: Fix `pkgs` not being recognized (replace w/ super?)
# TODO: Merge with mutter-mobile overlay?
# TODO: Remove `src` attr & use upstream?
# TODO: Push to cachix
(final: prev: {
  gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
    mutter = gnomePrev.mutter.overrideAttrs ( old: {
      patches = (old.patches or []) ++ [ "${pkgs.fetchpatch {
        url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441/diffs.patch";
        sha256 = "sha256-5r4UP4njxrfRebItzQBPrTKaPUzkWA+9727YdWgBCpA=";
      }}" ];
      src = pkgs.fetchgit {
        url = "https://gitlab.gnome.org/GNOME/mutter.git";
        rev = "3a94822e755e530b71c33bb5bce0e8faa438983c";
        sha256 = "sha256-BTBDEIefqFmzMEE85KwEhkcNlL/9UaMp10rXjWmspKQ=";
      };
    } );
  });
})
