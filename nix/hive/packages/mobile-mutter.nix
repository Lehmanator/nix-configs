{
  lib,
  fetchpatch,
  fetchFromGitLab,
  gnome,
  ...
}: let
  branch = rec {
    # Branch: mobile-shell (09/23)
    mobile-mutter = {
      rev = "0f08f5aba4c9b5ac34b2d5711182d50b719d838e";
      hash = "sha256-du56QMOlM7grN60eafoGTw2JGND6PK1gLrfWufihPO4=";
    };

    # Branch: mobile-shell-devel (11/23)
    mobile-mutter-devel = {
      rev = "2c538763f7cdcd8dec29fbf602b930c60862f019";
      hash = "sha256-D9TWF09XhqfBZyKXiPaQE+Fa+3mKG2CAdyi8nAsYa+c=";
    };

    stable = mobile-mutter;
    develop = mobile-mutter-devel;
  };
in
  gnome.mutter.overrideAttrs (finalAttrs: rec {
    version = "45.2";
    src = fetchFromGitLab {
      domain = "gitlab.gnome.org";
      owner = "verdre";
      repo = "mobile-mutter";
      rev =
        if isDevel
        then branch.mobile-mutter-devel.rev
        else branch.mobile-mutter.rev;
      hash =
        if isDevel
        then branch.mobile-mutter-devel.hash
        else branch.mobile-mutter.hash;
    };

    # TODO: Update rev/hash for patches.
    patches =
      lib.optional isDynamicBuffering (fetchpatch {
        url = "https://gitlab.gnome.org/GNOME/mutter/~/merge_requests/1441/diffs.patch";
        sha256 = "sha256-5r4UP4njxrfRebItzQBPrTKaPUzkWA+9727YdWgBCpA=";
      })
      ++ [
        #./sysprof.patch
      ];

    isMobile = true;
    isDevel = false;
    isDynamicBuffering = false;
  })
