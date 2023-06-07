{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    #inputs.nixpkgs-mozilla.overlay   # Imported in flake
  ];

  home.packages = [
    # https://github.com/mozilla/nixpkgs-mozilla
    # Docs say to build w/ flag --impure
    #pkgs.latest.firefox-nightly-bin      #firefox-{,beta,nightly,esr}-bin

    # https://github.com/colemickens/flake-firefox-nightly
    #inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin  # TODO: Add to inputs in flake.nix
  ];
}
