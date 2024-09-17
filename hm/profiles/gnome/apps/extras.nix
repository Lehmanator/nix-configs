{ pkgs, ... }: {
  home.packages = with pkgs; [
    fragments
    gimp-with-plugins
  ];
  # https://github.com/mikeroyal/NixOS-Guide

  # --- Apps ---
  # https://github.com/Bitsteward/bitsteward     # WIP Libadwaita Bitwarden client
  # https://github.com/Vanilla-OS/AdwDialog      # GTK4/Libadwaita dialogs from terminal/scripts
  # https://github.com/superwhiskers/layer-cake  # Minecraft Launcher
  # https://github.com/DeedleFake/trayscale      # GTK4 Tailscale CLI wrapper GUI
  # https://github.com/GradienceTeam/Gradience   # Adwaita themer
  # https://github.com/igorgue/neowaita          # Neovim GTK4/Libadwaita UI
  # https://github.com/aspinwall-ui/lapel        # Voice assistant GUI based on Mycroft
  # https://github.com/marhkb/pods               # Podman manager
  # https://github.com/an-anime-team/honkers-launcher-gtk # Honkers game launcher

  # --- System Themes ---
  # https://github.com/lassekongo83/adw-gtk3           # Libadwaita theme for GTK3 w/ custom colors
  # https://github.com/lassekongo83/adw-colors         # Style Libadwaita & adw-gtk3 w/ named colors
  # https://github.com/avanisubbiah/material-you-theme # Material You theming for Libadwaita, GNOME-Shell, GDM
  # https://github.com/davidphilipbarr/gnome-hacks     # CSS themes & other hacks for GNOME
  # https://github.com/davidphilipbarr/gnos-icons      # Extra GNOME icons
  # https://github.com/davidphilipbarr/adw-gtk-additional # Extra CSS styles to fix GTK2/3 context menus
  # https://github.com/xelser/libadwaita-gnome-shell   # GNOME-Shell CSS styles
  # https://github.com/FabianOvrWrt/adw-xfwm4          # XFWM4 Libadwaita theme

  # https://github.com/dgsasha/qualia-gtk-theme        # Themes: GTK3, Libadwaita config, Firefox, VSCode, GNOME-Shell, Budgie, Cinnamon, Unity7, XFCE, Mate
  # https://github.com/odziom91/libadwaita-themes      # GTK4 Themes modded to work w/ Libadwaita
  # https://github.com/GabePoel/KvLibadwaita           # Kvantum theme
  # https://github.com/marcelovbcfilho/adw-xfwm        # XFWM
  # https://github.com/GradienceTeam/Community         # Gradience presets for theming GTK/Libadwaita & more

  # --- App Themes ---
  # https://github.com/wroyca/libadwaita-vscode-theme  # VSCode Adwaita (better, but requires Custom CSS & JS Loader extension)
  # https://github.com/piousdeer/vscode-adwaita        # VSCode Adwaita theme
  # https://github.com/birneee/obsidian-adwaita-theme  # Obsidian Notes Libadwaita theme
  # https://github.com/Foldex/AdwSteamGtk              # Steam
  # https://github.com/GittyMac/libadwaita-dark-cider  # Cider music player
  # https://github.com/leodr/ulauncher-theme-libadwaita  # uLauncher app launcher
  # https://github.com/drakkar1969/mailspring-libadwaita-theme    # Mailspring Email client
  # https://github.com/V8V88V8V88/Telegram-GTK4-Libadwaita-Theme  # Telegram Desktop

  # --- Other Platforms ---
  # https://github.com/AnthemV/GNOME-CSS               # Userstyles to theme various websites in Libadwaita style
  # https://github.com/ncpa0cpl/adwaita-web            # GTK/Adwaita React UI framework
  # https://github.com/mayudev/webadwaita              # Libadwaita CSS framework
  # https://github.com/gtk-flutter/libadwaita_plugins  # Libadwaita Flutter plugins
  # https://github.com/MSM74588/tauri-libadwaita-template # Libadwaita Tauri app Svelte toolkit

  # --- Templates ---
  # https://github.com/allaeddineomc/adwaita-svg       # SVG files for Libadwaita prototyping
  # https://github.com/timlau/adw_template_app         # GTK4/Libadwaita/Blueprint/Flatpak Python app template
  # https://github.com/krypt0nn/gtk-example-app        # GTK4/Libadwaita/Blueprint Rust app template
  # https://github.com/j0hax/libadwaita-flake          # Nix flake template to build Libadwaita app
}
