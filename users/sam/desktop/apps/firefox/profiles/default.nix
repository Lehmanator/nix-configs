{ self, inputs,
  config, lib, pkgs,
  ...
}:
#let
#  #foldImport = with lib.lists; t: (fold (x: y: unique (x ++ import "../${t}/${y}.nix")) "default");
#  #importTitle     = t: f:  import "../${t}/${f}.nix";
#  importTitle     = t: f:  import "../${t}/${f}.nix" {inherit pkgs;};
#  importTitles    = t: fs: lib.lists.forEach (fs++["default"]) (importTitle t);
#  importTitleAttr = t: a:  importTitles t a."${t}";
#  importAttrs     = t: a:  lib.list.fold (x: y: lib.attrsets.recursiveUpdate x y) {} (importTitleAttr t a);
#  importLists     = t: a:  lib.list.fold (x: y: lib.lists.unique x++y) [] importTitleAttr t a;
#
#  foldImportList = t: att: lib.lists.fold (x: y: lib.lists.unique (x ++ import "../${t}/${y}.nix")) "default";
#  foldImportListPkg = t: lib.lists.fold (x: y: lib.lists.unique (x ++ import "../${t}/${y}.nix" {inherit pkgs;})) "default";
#  foldImportAttrsPkg = t: att: lib.lists.fold (x: y: lib.attrsets.recursiveUpdate x (import "../${t}/${y}.nix" {inherit pkgs;})) "default" att."${t}";
#  foldImportStr = t: att: (lib.lists.concatStringSep "\n" (
#    lib.lists.forEach (att."${t}"++["default"]) (s: import "../styles/${t}/${s}.nix")
#  ));
#  mkFirefoxProfile = name: imports: overrides: {
#    inherit name;
#    isDefault      = false;
#    bookmarks      = foldImportList imports.bookmarks;
#    #forEach ([ "default" ] ++ imports) ()
#    #foldr (x: y: x ++ y)
#    #(unique forEach ([ "default" ] ++ imports) (b: import "../bookmarks/${b}.nix"));
#    #search.engines = import ../search {inherit pkgs;};
#    #extensions     = import ../extensions {inherit pkgs;};
#    extensions     = foldImportListPkg "extensions" imports;
#    search.default = "DuckDuckGo";
#    search.engines = foldImportAttrsPkg "search" imports;
#    settings       = import ../settings;
#    userChrome     = foldImportStr "chrome"  imports;
#    userContent    = foldImportStr "content" imports;
#  } // overrides;
#in
{
  # TODO: `../styles/chrome/gnome.nix`        # firefox-gnome-theme port to Nix
  # TODO: `../styles/chrome/mobile.nix`       # firefox-mobile-css  port to Nix, read global option
  # TODO: `../styles/content/dark-mode.nix`   # Adapt websites to light/dark mode
  # TODO: `../styles/content/colors.nix`      # Material You theming based on desktop wallpaper

  # Install firefox extension packages from rycee's NUR repo
  home.packages = [
    pkgs.nur.repos.rycee.mozilla-addons-to-nix
  ];

  # Build default profile from imports
  programs.firefox.profiles.default = {
    isDefault = true;
    name = "Default";

    #bookmarks      = import ../bookmarks;
    extensions     = import ../extensions { inherit pkgs; };
    #search.default = "DuckDuckGo";
    #settings       = import ../settings;
  };

  programs.firefox.profiles.testing = {
    isDefault = false;
    id = 1;
    name = "Testing";

    bookmarks      = import ../bookmarks;
    extensions     = import ../extensions { inherit pkgs; };
    search.default = "DuckDuckGo";
    search.engines = import ../search     { inherit pkgs; };
    settings       = import ../settings;
    userChrome     = import ../styles/chrome ;
    userContent    = import ../styles/content;
  };
}
