self: super:
{
  gnome = super.gnome.overrideScope' (gself: gsuper: {
    gnome-shell = gsuper.gnome-shell.overrideAttrs (old: {
      version = "44.0-mobile";
      src = super.fetchgit {
        url = "https://gitlab.gnome.org/verdre/gnome-shell.git";
        #rev = "0c42fe4cc05c54a737400973cc5dc8ff9ba51bca";
        #sha256 = "NS4/y7xKIexa76Ltr/Rniflb7zTLEboKXlVe75+U/sk=";
        rev = "8625e2fb1d486d9e2de4772844bc69a256f1b05c";
        sha256 = "igzxvqG5kNBO8Oe/3bm775hGMCOfRh2790X/ES51yf4=";
      };
      postPatch = ''
        patchShebangs src/data-to-c.pl

        # We can generate it ourselves.
        rm -f man/gnome-shell.1
      '';
      postFixup = ''
        # The services need typelibs.
        for svc in org.gnome.ScreenSaver org.gnome.Shell.Extensions org.gnome.Shell.Notifications org.gnome.Shell.Screencast; do
          wrapGApp $out/share/gnome-shell/$svc
        done
      '';
    });

    mutter = gsuper.mutter.overrideAttrs (old: {
      version = "44.0-mobile";
      src = super.fetchgit {
        url = "https://gitlab.gnome.org/verdre/mutter.git";
        #rev = "585802e5afeb268251dbb202f7d108fdf4f51da4";
        #sha256 = "171dh09akfb1mdbzrnbnjrz3hinvjiivzwyqwzi7lvyiysy179hd";
        rev = "780aadd4ed77ca6a8312acb3ab13decdb5b6d569";
        sha256 = "0B1HSwnjJHurOYg4iquXZKjbfyGM5xDIDh6FedlBuJI=";
      };
      buildInputs = old.buildInputs ++ [
        super.gtk4
      ];
      outputs = [ "out" "dev" "man" ];
      postFixup = '' '';
      patches = [ ];
    });
  });
}
