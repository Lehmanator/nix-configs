{lib, ...}: {
  # https://nixos.wiki/wiki/Ca-derivations
  # https://www.tweag.io/blog/2020-09-10-nix-cas/
  # https://edolstra.github.io/pubs/phd-thesis.pdf#page=143
  # https://discourse.nixos.org/t/tweag-nix-dev-update-12/13185/3
  nixpkgs.config.contentAddressedByDefault = lib.mkDefault false;
  nix = {
    settings = {
      experimental-features = [
        "ca-derivations"
        #"git-hashing" # Not enabled until Nix version v?
      ];
      # Enable content-addressed binary cache
      substituters = ["https://cache.ngi0.nixos.org/"];
      trusted-substituters = ["https://cache.ngi0.nixos.org/"];
      trusted-public-keys = [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      ];
    };
  };
}
