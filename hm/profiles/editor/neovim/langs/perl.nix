{ inputs
, pkgs
, ...
}:
{

  # --- Perl ---------------------------
  # Fixes Neovim Perl healthcheck
  home.packages = [
    pkgs.nix-generate-from-cpan
    pkgs.perl536Packages.CPAN
  ];

}

