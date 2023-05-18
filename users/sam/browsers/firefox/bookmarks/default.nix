#{ self, inputs, config, lib, pkgs, ... }:
[
  #programs.firefox.profiles.default.bookmarks = [...];

  # TODO: Import bookmarks inside profiles & concat lists
  # TODO: Move the NixOS items to ./nix.nix
  { name = "NixOS Options";  url = "https://search.nixos.org/options";  }
  { name = "NixOS Packages"; url = "https://search.nixos.org/packages"; }
  { name = "NixOS Flakes";   url = "https://search.nixos.org/flakes";   }
  { name = "NixOS Wiki";     url = "https://nixos.wiki";                }
  { name = "NixOS Libs";     url = "https://noogle.dev";                }
]
