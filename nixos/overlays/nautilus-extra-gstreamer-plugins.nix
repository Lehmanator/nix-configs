# https://nixos.wiki/wiki/Nautilus
(self: super: {
  gnome = super.gnome.overrideScope' (gself: gsuper: {
    nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
      buildInputs = nsuper.buildInputs ++ (with super.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
      ]);
    });
  });
})
