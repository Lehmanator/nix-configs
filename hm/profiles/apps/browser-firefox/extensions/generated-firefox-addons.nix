{ buildFirefoxXpiAddon, fetchFromGitHub, fetchgit, fetchurl, lib, stdenv }:
{

  # Notes:
  # - Sidebery Git repo has `flake.nix`, but only provides devenv
  #   (https://github.com/mbnuqw/sidebery)
  # - Based on Rycee's NUR: `pkgs.nur.rycee.firefox-addons`
  #   - Original file: auto-generated Nix configuration to create `firefox-addons` packages.
  #   - Original file: includes older revision of Sidebery addon.
  #   - Original file: `generated-firefox-addons.nix`
  #     (https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix)
  # - This snippet exists solely for:
  #   - Tracking latest Sidebery code from Git
  #   - Apply custom `userChrome.css` styling to Sidebery panel & tabs to fit in better with the platform (GNOME / KDE).
  "sidebery" = buildFirefoxXpiAddon rec {
    pname = "sidebery";
    version = "5.0.0";   #rc4
    addonId = "{3c078156-979c-498b-8990-85f7987dd929}";

    #version = "4.10.2";
    #url = "https://addons.mozilla.org/firefox/downloads/file/3994928/sidebery-${version}.xpi";
    #sha256 = "60e35f2bfac88e5b2b4e044722dde49b4ed0eca9e9216f3d67dafdd9948273ac";

    src = fetchFromGitHub {
      owner = "mbnuqw";
      repo = "sidebery";
      rev = "3bb0955ca8d71bc43c6e57ba1024bcec4bffc56a";
      #rev = "v5";
      sha256 = "";
    };

    meta = with lib; {
      homepage = "https://github.com/mbnuqw/sidebery";
      description = "Tabs tree and bookmarks in sidebar with advanced containers configuration.";
      license = licenses.mit;
      mozPermissions = [ "bookmarks" "contextualIdentities" "cookies"
        "menus" "menus.overrideContext" "search" "sessions" "storage" "tabs" ];
      #optionalPermissions = [ "<all_urls>"     "proxy"   "webRequest" "webRequestBlocking"
      #  "bookmarks" "tabHide" "clipboardWrite" "history" "downloads"                       ];
      #];
      platforms = platforms.all;
    };

  };

  # Additional CSS styles for Firefox userChrome to style tab sidebar extensions to fit GNOME / KDE.
  "sidebery-gnome-css" = stdenv.mkDerivation {
    pname = "sidebery-gnome-css";
    version = "12022.11.29";         # Latest release (as of Sept 23) = v12022.11.29

    meta = with lib; {
      homepage = "https://github.com/drannex42/FirefoxSidebar";
      description = "Firefox CSS theme for sidebar extensions like Sidebery.";
      license = licenses.mit;
      platforms = platforms.all;
    };

    src = fetchFromGitHub {
      owner = "drannex42";
      repo = "FirefoxSidebar";
      rev = "60e064e67a5133ee520a972db8d338b3d224fa15";
      sha256 = "";
    };

    # Files:
    #
    # ./sidebery-data.json      # Extension settings to import into Sidebery settings
    #
    # ./userChrome.css          # Main CSS stylesheet to import the others
    # ./custom.css              # Custom User CSS overrides
    # ./prefs.css               # Theme preferences
    #
    # ./themes/gtk_adwaita.css  # Styles: GNOME Adwaita
    # ./themes/gtk_breeze.css   # Styles: KDE Breeze
    #
    # ./extensions/sidebar.css                # Sidebar impl                                        (default=true)
    # ./extensions/window_controls.css        # CSD / Window controls impl                          (default=true)
    # ./extensions/bookmark_arrow.css         # Add small arrow next to Bookmark dirs               (default=false)
    # ./extensions/superbox_removal.css       # Add small arrow next to Bookmark dirs               (default=true)
    # ./extensions/avatar_size.css            # Change Firefox account avatar size.                 (default=false)
    # ./extensions/fix_hidden_bookmarks.css   # Fix sidebar switcher if Bookmarks toolbar is hidden (default=false)
    # ./extensions/hide_sidebar_switcher.css  # Hide sidebar switcher.                              (default=false)
    #

  };

  # TODO: Import CSS stylesheets into Firefox configuration for each desired profile(s)
  # TODO: Create custom CSS overrides for personal preferences & import CSS in Firefox profile userChrome.css.
  # TODO: Implement some way of keeping this snippet up-to-date.
  # TODO: Figure out how this file should be imported.
  # TODO: Conditionally load the theme stylesheet based on desktop environment.

}
