#{ self, inputs,
#  lib, pkgs, config,
{ pkgs,
  ...
}:
{
  # TODO: Home Manager Options
  # TODO: NixOS Options
  # TODO: Nix Flakes
  # TODO: NUR Repos
  # TODO: Noogle.dev

  "Nix Packages" = {
    urls = [{
      template = "https://search.nixos.org/packages";
      params = [
        { name = "type"; value = "packages"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    definedAliases = [ "@np" ];
  };

  "NixOS Wiki" = {
    urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
    iconUpdateURL = "https://nixos.wiki/favicon.png";
    updateInterval = 24 * 60 * 60 * 1000; # every day
    definedAliases = [ "@nw" ];
  };
}
