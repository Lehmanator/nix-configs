{ inputs
, config
, lib
, pkgs
, program ? "firefox"
, profile ? "default"
, ...
}:
{
  imports = [
    # https://git.sr.ht/~rycee/nur-expressions/tree/master/item/pkgs/firefox-addons/flake.nix
    #inputs.nur.hmModules.
  ];

  programs."${program}".profiles."${profile}" = {
    extensions = [ pkgs.firefox-addons.adaptive-tab-bar-color ];
    settings = {
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };

    # https://gist.github.com/eilx/2e1346472598ddac5e2ec20f40695dfe
    userChrome = ''
    '' ++ (builtins.readFile ./adaptive-tab-bar-color_userChrome.css);

    userContent = ''
    '' ++ (builtins.readFile ./adaptive-tab-bar-color_userContent.css);

    # Extra preferences to add to user.js
    #extraConfig = ''
    #'';

    # --- Extension ----------------------------------------
    # addons.json
    #{ "slug": "adaptive-tab-bar-color", "pname": "adaptive-tab-bar-color" }

    # generated-firefox-addons.nix
    #"adaptive-tab-bar-color" = buildFirefoxXpiAddon rec {
    #  pname = "adaptive-tab-bar-color";
    #  url = "https://addons.mozilla.org/firefox/downloads/file/${id}/${pname}-${version}.xpi";
    ##  url = "https://addons.mozilla.org/firefox/addon/adaptive-tab-bar-color";
    #  meta = {
    #    homepage = "https://github.com/easonwong-de/Adaptive-Tab-Bar-Color";
    #    description = "Changes the color of Firefox tab bar to match the website theme";
    #    license = lib.licenses.mit;
    #    platforms = lib.platforms.all;
    #  };
    #};
  };
}
