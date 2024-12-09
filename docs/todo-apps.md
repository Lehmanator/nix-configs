# To-Dos: Apps

## Apps to Install via Nix

### Nixpkgs

- [ ] TODO: Swap w/ flatpak

```(nix)
home.packages = with pkgs; [
amberol      # Music player
celeste      # File synchronization app supporting Google Drive, Dropbox, Nextcloud, OwnCloud, WebDAV. (Future: OneDrive, Amazon S3)
contrast     # Check contrast & colorscheme accessibility (WCAG requirements)
emulsion-palette # Store color palettes
eyedropper   # Color picker & formatter
obs-studio   # Streaming & video recording suite
  obs-studio-plugins.obs-3d-effect wlrobs obs-ndi obs-vaapi obs-nvfbc obs-teleport obs-hyperion droidcam-obs obs-vkcapture obs-gstreamer input-overlay multi-rtmp obs-source-clone obs-shaderfilter obs-source-record obs-livesplit-one looking-glass-obs obs-vintage-filter obs-command-source obs-move-transition obs-backgroundremoval advanced-scene-switcher obs-pipewire-audio-capture
paleta       # Generate color paletes
pods         # Podman desktop application
sticky       # Sticky Notes app
];
```

- [ ] TODO: Install nixpkgs package

```(nix)
home.packages = with pkgs; [
authenticator
aviator          # Merge JSON/YAML files
boatswain        # Control Elgato Stream Deck devices
cambalache       # Rapid Application Development for GTK4 / GTK3
cavalier         # Audio visualizer
curtail          # Compress images
denaro           # Personal finance manager
dialect          # Translator
dino             # Jabber/XMPP client
  dynamic-wallpaper # Create dynamic wallpapers for GNOME
  eartag           # Music tag editor
  elastic          # Design spring animations
  emblem           # Generate project icons & avatars from a symbolic icon
  endeavour        # Personal task manager for GNOME
  flare-signal     # Unofficial Signal client
  formiko          # reStructuredText editor & live preview
  fragments        # Torrent client
  gaphor           # Simple modeling tool
  gnome-builder    # IDE for GNOME
  gnome-extension-manager # Manage GNOME Shell extensions w/ search & install functionality
  gnome-secrets    # Password manager for GNOME using KeePass v4 format
  gradience        # App to theme GNOME, GTK, & various apps according to palettes or wallpapers
  halftone         # Give images pixel-art style
  icon-library     # Symbolic icon catalog
  identity         # Compare multiple versions of an image or video
  mousai           # Identify playing music
  pika-backup      # Backup application
  portfolio-filemanager # Mobile-first file manager
  rnote            # Handwritten notes
  schemes          # Create / edit syntax highlighting style-schemes for GtkSourceView
  symbolic-preview # Create, preview, export symbolic icons easily
  tagger           # Music tag editor
  tangram          # Run web apps in tabbed app-like client
  video-trimmer    # Trim videos
  warp             # QR code file transfer
  wike             # Wikipedia client
];
```

- Installed package w/ nixpkgs

```(nix)
home.packages = with pkgs; [
  blackbox-terminal
  bottles #bottles-unwrapped
  imaginer # Stable Diffusion models & APIs for generating images from text description
];

```

## Flatpak-only (not in nixpkgs yet)

### GTK4 & Libadwaita

Find Apps Here: [This Week in GNOME](https://thisweek.gnome.org)

- <https://flathub.org/apps/app.drey.Blurble> - Wordle game
- <https://flathub.org/apps/app.drey.PaperPlane> - Telegram Client (Beta-only: 6/6/23)
- <https://flathub.org/apps/app.drey.MultiplicationPuzzle> - Puzzle game using multiplication
- <https://flathub.org/apps/com.belmoussaoui.ReadItLater> - Wallabag client for saving articles to read for later
- <https://flathub.org/apps/com.github.alexkdeveloper.forgetpass> - Password generator
- <https://flathub.org/apps/com.github.joseexposito.touche> - Multi-touch gestures for touchpads & touchscreens via Touchegg
- <https://flathub.org/apps/com.github.tchx84.Flatseal> - Flatpak Sandbox/Permissions manager
- <https://flathub.org/apps/com.mardojai.ForgeSparks> - Git merge
- <https://flathub.org/apps/com.rafaelmardojai.SharePreview> - Test social media cards locally
- <https://flathub.org/apps/de.schmidhuberj.tubefeeder> - Client for YouTube, LBRY, & PeerTube
- <https://flathub.org/apps/io.github.Bavarder.Bavarder> - Prompt for Large Language Models (LLMs). Supports APIs & local custom models.
- <https://flathub.org/apps/io.github.bytezz.IPLookup> - Find info about an IP address
- <https://flathub.org/apps/io.github.cleomenezesjr.Escambo> - HTTP API testing app
- <https://flathub.org/apps/io.github.diegoivan.pdf_metadata_editor> - PDF Metadata Editor
- <https://flathub.org/apps/io.github.fabrialberio.pinapp> - Create desktop launcher files (`.desktop`)
- <https://flathub.org/apps/io.github.fsobolev.TimeSwitch> - Run task after timer
- <https://flathub.org/apps/io.gitlab.gregorni.ASCIIImages> - Create ASCII art from images
- <https://flathub.org/apps/io.gitlab.gregorni.Calligraphy> - Fancy, stylized ASCII text generator
- <https://flathub.org/apps/io.github.jeffshee.Hidamari> - Live video wallpaper for Linux desktops
- <https://flathub.org/apps/io.github.lainsce.Colorway> - Generate color pairings from selected colors according to rules
- <https://flathub.org/apps/io.github.limads.Queries> - SQL query runner
- <https://flathub.org/apps/io.github.realmazharhussain.GdmSettings> - Configure GDM settings
- <https://flathub.org/apps/io.github.swanux.hbud> - Simple media player
- <https://flathub.org/apps/details/me.dusansimic.DynamicWallpaper> - pkgs.dynamic-wallpaper
- <https://flathub.org/apps/ir.imansalmani.IPlan> - Life & project planner
- <https://flathub.org/apps/org.gabmus.swatch> - Color palette manager
- <https://flathub.org/apps/org.gnome.design.Palette> - Tool to view GNOME color palette as defined by the design guidelines
- <https://flathub.org/apps/org.gnome.Snapshot> - New webcam app for GNOME
- <https://flathub.org/apps/org.nickvision.tubeconverter> - Download Video/Audio from YouTube & more w/ yt-dlp
- <https://flathub.org/apps/se.sjoerd.Graphs> - Plot equations on graph
- <https://flathub.org/apps/io.github.dubstar_04.design> - 2D CAD application
- <https://flathub.org/apps/details/io.github.mpobaschnig.Vaults> - Encrypted folder mounts

- <https://flathub.org/apps/details/io.gitlab.cyberphantom52.sudoku_solver>
- <https://flathub.org/apps/details/com.github.alexkdeveloper.sudoku>
- <https://flathub.org/apps/details/org.blackfennec.app> - Editor for structured data
- eu.nimmerfort.blackbody - Thermogram viewer

- <https://beta.flathub.org/apps/details/re.sonny.Retro>
- <https://beta.flathub.org/apps/com.vixalien.sticky> - Sticky Notes application. Notes stay on desktop
- <https://beta.flathub.org/apps/io.github.nate_xyz.Conjure> - ImageMagick photo manipulations w/ filters, transformations
- <https://beta.flathub.org/apps/io.github.nate_xyz.Resonance> - Rust music player supporting coloring UI to match cover art, playlists, MPRIS, Discord Rich Presence, Last.fm scrobbling, Mutagen tag import
- <https://beta.flathub.org/apps/me.iepure.devtoolbox> - Collection of development utils

- <https://apps.gnome.org/app/io.github.fkinoshita.Telegraph> - Morse code app
- <https://apps.gnome.org/app/hu.kramo.Cartridges> - Game Launcher for Steam, Lutris, Heroic, & more
- <https://gitlab.gnome.org/aplazas/metronome> - Metronome for keeping tempo
- <https://gitlab.gnome.org/jrb/crosswords> - Crossword puzzle game & creator
- <https://gitlab.gnome.org/Incubator/loupe> - New image viewer for GNOME
- <https://gitlab.gnome.org/World/chess-clock> - Stop clock for chess
- <https://gitlab.gnome.org/World/design/app-icon-preview> - Design tool for icons targeting GNOME desktop

- <https://github.com/eminfedar/vaktisalah-gtk-rs> - Prayer times
- <https://github.com/sonnyp/Playhouse> - Playground for HTML, CSS, JS
- <https://github.com/sonnyp/Workbench> - App sandbox to learn & prototype w/ GNOME technologies
- <https://framagit.org/tractor/carburetor> - GUI for tractor, a package to provide a connection thru the onion proxy & sets up proxy in user session. Tor, but without the need to manually configure. TODO: Package for Nix

- `flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo && flatpak install io.github.alainm23.planify` - To-Dos, Tasks, & Time Planner

- collision
- workbench
- shotcut # nixpkgs version out-of-date

- <https://github.com/alexkdeveloper/somafm>
- <https://github.com/alexkdeveloper/dwxmlcreator>
- <https://github.com/alexkdeveloper/notepad>
- <https://github.com/alexkdeveloper/easter>
- <https://github.com/alexkdeveloper/radio>
- <https://github.com/alexkdeveloper/relaxator>
- <https://github.com/alexkdeveloper/goldsearch>
- <https://github.com/alexkdeveloper/desktop-files-creator>
- <https://github.com/alexkdeveloper/astronum>
- <https://github.com/alexkdeveloper/gomoku>
- <https://github.com/alexkdeveloper/dice>
- <https://github.com/alexkdeveloper/recorder>

- <https://github.com/bytezz/iplookup-gtk>
- <https://github.com/limads/queries>
- <https://github.com/fabrialberio/PinApp>
- <https://gitlab.gnome.org/lwildberg/meeting-point> - app.drey.MeetingPoint
- <https://flathub.org/apps/details/org.gnome.design.Lorem>
- <https://flathub.org/apps/details/io.gitlab.adhami3310.Converter>
- <https://flathub.org/apps/details/io.gitlab.theevilskeleton.Upscaler>
- <https://flathub.org/apps/details/nl.g4d.Girens>
- <https://flathub.org/apps/details/fr.romainvigier.zap>

- <https://gitlab.gnome.org/GNOME/krb5-auth-dialog>
