{
  inputs,
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../teams.nix
  ];

  xdg.desktopEntries = let
    browser = "firefox";
    ffProfile = profileName: "${pkgs.firefox}/bin/firefox -P ${profileName}";
    gwProfile = profileName: "${pkgs.epiphany}/bin/epiphany --application-mode --profile=${config.xdg.dataHome}/epiphany/${profileName}";
    mkExec = url: (if browser == "firefox" then (ffProfile "default") else (gwProfile "default")) + " ${url}";
      #"${pkgs.firefox}/bin/firefox";
      #"${pkgs.epiphany}/bin/epiphany";
    base = {
      categories = ["Application" "Communication" "Office" "WebApp"];
      terminal = false;
      startupNotify = false;
    };

  in {

    work-start = lib.attrsets.recursiveMerge base {
      name = "Start Work";
      genericName = "Start Work";
      comment = "Start your workday";
      exec = "${pkgs.teams-for-linux}/bin/teams-for-linux";
      type = "Application";
      actions = {
      };
      settings = {
        Keywords = "";
        DBusActivatable = true;
      };
    };

    outlook = lib.attrsets.recursiveMerge base {
      name = "Microsoft Outlook";
      genericName = "Email";
      comment = "Launch Microsoft Outlook as web app.";
      exec = mkExec + "";
      type = "Link";
      actions = {
      };
      settings = {
        Keywords = "";
        DBusActivatable = true;
      };
    };

    azure-portal = lib.attrsets.recursiveMerge base {
      categories = [ "Sysadm"];
      comment = "Launch Microsoft Azure Portal";
      exec = mkExec + "";
    };

    piwine-home = lib.attrsets.recursiveMerge base {
      categories = ["WebDev"];
      comment = "Load Presque Isle Wine Cellars homepage.";
      exec = mkExec "https://www.piwine.com";
    };

    piwine-config = lib.attrsets.recursiveMerge base {
      categories = ["WebDev"];
      comment = "Load Presque Isle Wine Cellars configuration backend.";
      exec = mkExec "https://www.piwine.com/cgi-piwine/bo/start.cgi";
    };
  };

}

#Usage: /nix/store/13hzzxhgl6fl5vj9zxa2n847bs7k8164-firefox-115.0.2/bin/.firefox-wrapped [ options ... ] [URL]
#       where options include:
#
#X11 options
#  --display=DISPLAY  X display to use
#  --sync             Make X calls synchronous
#  --g-fatal-warnings Make all warnings fatal
#
#Firefox options
#  -h or --help       Print this message.
#  -v or --version    Print Firefox version.
#  --full-version     Print Firefox version, build and platform build ids.
#  -P <profile>       Start with <profile>.
#  --profile <path>   Start with profile at <path>.
#  --migration        Start with migration wizard.
#  --ProfileManager   Start with ProfileManager.
#  --no-remote        Do not accept or send remote commands; implies
#                     --new-instance.
#  --new-instance     Open new instance, not a new window in running instance.
#  --safe-mode        Disables extensions and themes for this session.
#  --allow-downgrade  Allows downgrading a profile.
#  --MOZ_LOG=<modules> Treated as MOZ_LOG=<modules> environment variable,
#                     overrides it.
#  --MOZ_LOG_FILE=<file> Treated as MOZ_LOG_FILE=<file> environment variable,
#                     overrides it. If MOZ_LOG_FILE is not specified as an
#                     argument or as an environment variable, logging will be
#                     written to stdout.
#  --headless         Run without a GUI.
#  --browser          Open a browser window.
#  --new-window <url> Open <url> in a new window.
#  --new-tab <url>    Open <url> in a new tab.
#  --private-window <url> Open <url> in a new private window.
#  --preferences      Open Preferences dialog.
#  --screenshot [<path>] Save screenshot to <path> or in working directory.
#  --window-size width[,height] Width and optionally height of screenshot.
#  --search <term>    Search <term> with your default search engine.
#  --setDefaultBrowser Set this app as the default browser.
#  --first-startup    Run post-install actions before opening a new window.
#  --kiosk            Start the browser in kiosk mode.
#  --disable-pinch    Disable touch-screen and touch-pad pinch gestures.
#  --jsconsole        Open the Browser Console.
#  --devtools         Open DevTools on initial load.
#  --jsdebugger [<path>] Open the Browser Toolbox. Defaults to the local build
#                     but can be overridden by a firefox path.
#  --wait-for-jsdebugger Spin event loop until JS debugger connects.
#                     Enables debugging (some) application startup code paths.
#                     Only has an effect when `--jsdebugger` is also supplied.
#  --start-debugger-server [ws:][ <port> | <path> ] Start the devtools server on
#                     a TCP port or Unix domain socket path. Defaults to TCP port
#                     6000. Use WebSocket protocol if ws: prefix is specified.
#  --marionette       Enable remote control server.
#  --remote-debugging-port [<port>] Start the Firefox Remote Agent,
#                     which is a low-level remote debugging interface used for WebDriver
#                     BiDi and CDP. Defaults to port 9222.
#  --remote-allow-hosts <hosts> Values of the Host header to allow for incoming requests.
#                     Please read security guidelines at https://firefox-source-docs.mozilla.org/remote/Security.html
#  --remote-allow-origins <origins> Values of the Origin header to allow for incoming requests.
#                     Please read security guidelines at https://firefox-source-docs.mozilla.org/remote/Security.html
