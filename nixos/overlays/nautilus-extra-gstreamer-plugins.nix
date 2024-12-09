# https://wiki.nixos.org/wiki/Nautilus
(self: super: {
  nautilus = super.nautilus.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ (with super.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
    ]);
  });
})
