{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # https://nixos.wiki/wiki/Ca-derivations
  # https://www.tweag.io/blog/2020-09-10-nix-cas/
  # https://edolstra.github.io/pubs/phd-thesis.pdf#page=143
  # https://discourse.nixos.org/t/tweag-nix-dev-update-12/13185/3
  nix = {
    config.contentAddressedByDefault = true;
    settings = {
      experimental-features = ["ca-derivations" "fetch-closure"];
      substituters = ["https://cache.ngi0.nixos.org/"];
      trusted-public-keys = ["cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="];
    };
  };
}
