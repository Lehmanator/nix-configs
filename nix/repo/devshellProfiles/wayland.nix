{ inputs, cell
, config, lib, pkgs
, ...
}:
{
  # https://github.com/YaLTeR/wl-clipboard-rs
  packages = [
    pkgs.wl-kbptr        # Control mouse pointer w/ keyboard on Wayland
    pkgs.wl-mirror       # Simple Wayland output mirror client
    pkgs.wl-screenrec    # wlroots screen recording w/ hardware encoding
    pkgs.wl-color-picker # Wayland color picker that also works on wlroots
    pkgs.wl-clipboard-rs # Command-line copy/paste utils for Wayland in Rust
    pkgs.wl-clip-persist # Keep Wayland clipboard even after programs close
  ];

  commands = [
   { command = "${pkgs.wl-clipboard-rs}/bin/wl-copy";  name = "clip-copy";  help = "Copy from the system clipboard";  }
   { command = "${pkgs.wl-clipboard-rs}/bin/wl-paste"; name = "clip-paste"; help = "Paste from the system clipboard"; }
   { command = "${pkgs.wl-clipboard-rs}/bin/wl-clip";  name = "clip";       help = "Emulate xclip for Wayland";       }
   { command = "clip-paste | $@ | clip-copy";   name = "clip-wrap-command"; help = "Wrap command with copy & paste";  }
  ];

}
