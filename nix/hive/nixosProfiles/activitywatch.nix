{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/ActivityWatch/awesome-activitywatch
  # AFK:              https://github.com/ActivityWatch/aw-watcher-afk
  # Core:             https://github.com/ActivityWatch/aw-core
  # Data Analyzer:    https://github.com/ActivityWatch/aw-research
  # Sync Server Rust: https://github.com/ActivityWatch/aw-server-rust/tree/master/aw-sync
  # Sync Server:      https://github.com/ActivityWatch/aw-server
  # Web Extension:    https://github.com/ActivityWatch/aw-watcher-web
  # Window Watcher:   https://github.com/ActivityWatch/aw-watcher-window-wayland
  # Window Watcher:   https://github.com/ActivityWatch/aw-watcher-window

  # Anki Flashcards:  https://github.com/abdnh/aw-watcher-anki
  # Question Asker:   https://github.com/bcbernardo/aw-watcher-ask
  # Resource Usage:   https://github.com/Alwinator/aw-watcher-utilization
  # Tmux:             https://github.com/akohlbecker/aw-watcher-tmux

  # --- Media -------
  # Chromecast:       https://github.com/ActivityWatch/aw-watcher-chromecast
  # OpenVR:           https://github.com/ActivityWatch/aw-watcher-openvr
  # Spotify:          https://github.com/ActivityWatch/aw-watcher-spotify
  # MPV:              https://github.com/RundownRhino/aw-watcher-mpv-sender
  # Steam:            https://github.com/Edwardsoen/aw-watcher-steam

  # --- Editors -----
  # Vim Plugin:       https://github.com/ActivityWatch/aw-watcher-vim
  # VSCode Extension: https://github.com/ActivityWatch/aw-watcher-vscode
  # Emacs:            https://github.com/pauldub/activity-watch-mode
  # JetBrains IDEs:   https://github.com/OlivierMary/aw-watcher-jetbrains

  # --- Importers ---
  # Apple Screentime: https://github.com/ActivityWatch/aw-import-screentime
  # Calendar Import:  https://github.com/ActivityWatch/aw-import-ical
  # SmarterTime App:  https://github.com/ActivityWatch/aw-importer-smartertime

  # --- GUIs --------
  # Android App:      https://github.com/ActivityWatch/aw-android
  # Tauri App:        https://github.com/ActivityWatch/aw-tauri
  # Web UI:           https://github.com/ActivityWatch/aw-webui
  # GTK App:          https://flathub.org/apps/com.gitlab.cunidev.Workflow
  # MacOS:            https://github.com/jca41/codewatch
  # QT App:
  # TODO: Fork web extension repo, modify hardcoded value
  programs.firefox.policies = {
    "3rdparty" = {
      "Extensions" = {
        "{ef87d84c-2127-493f-b952-5b4e744245bc}" = {
          consentOfflineDataCollection = true;
        };
      };
    };
  };

start-sh = ''
  #!/bin/bash

  cd ~/.local/opt/activitywatch           # Put your ActivityWatch install folder here

  ./aw-server/aw-server &
  ./aw-watcher-afk/aw-watcher-afk &
  ./aw-watcher-window/aw-watcher-window & # you can add --exclude-title here to exclude window title tracking for this session only

  notify-send "ActivityWatch started"     # Optional, sends a notification when ActivityWatch is started
'';

kill-sh = ''
  #!/bin/bash
  pkill aw-
  notify-send "ActivityWatch killed"      # Optional, sends a notification when ActivityWatch is killed
'';

aw-start-desktop = ''
  [Desktop Entry]
  Name=Start ActivityWatch
  Comment=Start AW
  Exec=~/.local/opt/activitywatch/start.sh
  Hidden=false
  Terminal=false
  Type=Application
  Version=1.0
  Icon=activitywatch
  Categories=Utility;
'';

aw-kill-desktop = ''
  [Desktop Entry]
  Name=Kill ActivityWatch
  Comment=Kill AW
  Exec=~/.local/opt/activitywatch/kill.sh
  Hidden=false
  Terminal=false
  Type=Application
  Version=1.0
  Icon=activitywatch
  Categories=Utility;
'';
}
