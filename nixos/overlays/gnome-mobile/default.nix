final: prev: {
  # Base override/patch description from:
  # https://github.com/vlinkz/mobile-nixos/blob/ac0aff0ccf28fd34b4a8119e25d488687121982c/examples/gnome/overlay/default.nix
  # Custom overrides:
  # - Change fetcher:    fetchgit -> fetchFromGitLab
  # - Change repo:    gnome-shell -> mobile-shell
  # - Change repo:         mutter -> mobile-mutter
  # - Change version: 43.1-mobile -> 45.1-mobile
  # - Change hash fmt: sha256="." -> hash = "sha256-."
  # - Update repos rev+hash
  gnome = prev.gnome.overrideScope' (gfinal: gprev: {
    gnome-shell = gprev.gnome-shell.overrideAttrs (old: {
      version = "45.2-mobile";
      src = prev.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "verdre";
        repo = "mobile-shell";
        rev = "df3f6b4c512d2f181e86ff7f6b1646ce7b907344"; #              # Branch: mobile-shell       (09/23)
        hash = "sha256-s47z1q+MZWogT99OkzgQxKrqFT4I0yXyfGSww1IaaFs="; #  # Branch: mobile-shell       (09/23)
        fetchSubmodules = true;
      };
      buildInputs = old.buildInputs ++ [ prev.modemmanager ]; #prev.cmake ];
      # The services need typelibs.
      postFixup = ''
        patchShebangs src/data-to-c.pl
        rm -f man/gnome-shell.1
        for svc in org.gnome.ScreenSaver org.gnome.Shell.Extensions org.gnome.Shell.Notifications org.gnome.Shell.Screencast; do wrapGApp $out/share/gnome-shell/$svc done
      '';
    });
    gnome-shell-mobile-devel = gfinal.gnome-shell.overrideAttrs (old: {
      version = "45.2-mobile-devel";
      src = prev.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "verdre";
        repo = "mobile-shell";
        rev = "58146d2cce4f81a2eb2de0721bb730040f0e6118"; #             # Branch: mobile-shell-devel (11/23)
        hash = "sha256-b9TJlePcBi9njlly7Qx5UpfLj9pbTQUaB9rztNcnUMA="; # # Branch: mobile-shell-devel (11/23)
        fetchSubmodules = true;
      };
    });

    mutter-mobile = gprev.mutter.overrideAttrs (old: {
      version = "45.2-mobile";
      src = prev.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "verdre";
        repo = "mobile-mutter";
        rev = "0f08f5aba4c9b5ac34b2d5711182d50b719d838e"; #           # Branch: mobile-shell       (09/23)
        hash = "sha256-du56QMOlM7grN60eafoGTw2JGND6PK1gLrfWufihPO4="; # Branch: mobile-shell       (09/23)
        #rev = "ff4d87727b0ccbf626dbac5ab75ae3f4a896182e"; #          # Branch: main               (08/23)
        #hash = "";
      };
      #patches = [ ./sysprof.patch ];
      #buildInputs = old.buildInputs ++ [ prev.gtk4 ];
      #outputs = [ "out" "dev" "man" ];
    });
    mutter-mobile-devel = gfinal.mutter.overrideAttrs (old: {
      version = "45.2-mobile-devel";
      src = prev.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "verdre";
        repo = "mobile-mutter";
        rev = "2c538763f7cdcd8dec29fbf602b930c60862f019"; #           # Branch: mobile-shell-devel (11/23)
        hash = "sha256-D9TWF09XhqfBZyKXiPaQE+Fa+3mKG2CAdyi8nAsYa+c="; # Branch: mobile-shell-devel (11/23)
      };
    });

  });
}
