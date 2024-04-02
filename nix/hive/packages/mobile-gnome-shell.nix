{
  callPackage,
  fetchFromGitLab,
  fetchpatch,
  lib,
  gnome,
  modemmanager,
  ...
}: let
  branch = rec {
    # Branch: mobile-shell (09/23)
    mobile-shell = {
      rev = "df3f6b4c512d2f181e86ff7f6b1646ce7b907344";
      hash = "sha256-s47z1q+MZWogT99OkzgQxKrqFT4I0yXyfGSww1IaaFs=";
    };

    # Branch: mobile-shell-devel (11/23)
    mobile-shell-devel = {
      rev = "58146d2cce4f81a2eb2de0721bb730040f0e6118";
      hash = "sha256-b9TJlePcBi9njlly7Qx5UpfLj9pbTQUaB9rztNcnUMA=";
    };
    stable = mobile-shell;
    develop = mobile-shell-devel;
  };
in
  gnome.gnome-shell.overrideAttrs (finalAttrs: rec {
    version = "45.2";
    src = fetchFromGitLab {
      domain = "gitlab.gnome.org";
      owner = "verdre";
      repo = "mobile-shell";
      fetchSubmodules = true;
      rev =
        (
          if isDevel
          then branch.mobile-shell-devel
          else branch.mobile-shell
        )
        .rev;
      hash =
        (
          if isDevel
          then branch.mobile-shell-devel
          else branch.mobile-shell
        )
        .hash;
    };

    isMobile = true;
    isDevel = false;
    isDynamicRefresh = false; # TODO fetchpatch for dynamic buffering.

    builtInputs =
      finalAttrs.buildInputs
      ++ lib.optionals isMobile [modemmanager];

    # The services need typelibs.
    postFixup = ''
      patchShebangs src/data-to-c.pl
      rm -f man/gnome-shell.1
      for svc in org.gnome.ScreenSaver org.gnome.Shell.Extensions org.gnome.Shell.Notifications org.gnome.Shell.Screencast; do wrapGApp $out/share/gnome-shell/$svc done
    '';
  })
#.override {
#  mutter = callPackage ./mobile-mutter.nix {};
#  #inherit (inputs.cell.packages) mutter;
#}
