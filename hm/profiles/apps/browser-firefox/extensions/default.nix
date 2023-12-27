# --- Extensions ---
# TODO: `./gnome.nix`                  # gnome-shell-connector & misc GNOME integration
# TODO: `./ublock/default.nix`         # uBlock Origin ext, custom blocklists & rules
# TODO: `./vimium.nix`                 # Set global option for system-wide vim keybinds
# TODO: `./violentmonkey/default.nix`  # Custom userScripts (firemonkey vs violentmonkey)
# TODO: `./bitwarden.nix`              # Bitwarden password manager
# TODO: `./pass.nix`                   # Pass password manager
# TODO: `./keepass.nix`                # Pass password manager

{ inputs
, pkgs
#, config, lib, pkgs
, ...
}:
with pkgs.nur.repos.rycee.firefox-addons;
#with inputs.nur.repos.rycee.firefox-addons;
[
  #inputs.nur.repos.bandithedoge.firefoxAddons.downthemall
  #inputs.nur.repos.bandithedoge.firefoxAddons.sponsorblock
  #inputs.nur.repos.colinsane.firefox-extensions.bypass-paywalls-clean
  #pkgs.nur.repos.bandithedoge.firefoxAddons.downthemall
  #pkgs.nur.repos.bandithedoge.firefoxAddons.sponsorblock
  #pkgs.nur.repos.colinsane.firefox-extensions.bypass-paywalls-clean  # Error: Invalid meta attrset

  # --- User Scripts/Styles ---
  firemonkey   #greasemonkey tampermonkey violentmonkey
  #stylus

  # --- Block Ads -----------
  adnauseam
  #ghostery
  #sponsorblock
  #ublock-origin
  #umatrix
  #unpaywall

  # --- Block Tracking ------
  behave
  canvasblocker
  #censor-tracker
  clearurls
  #decentraleyes
  #disable-javascript
  #disconnect  # Block trackers
  #libredirect
  localcdn  #localcdn-fork-of-decentraleyes  #localcdn
  multi-account-containers
  noscript
  #pay-by-privacy-com  # Generate virtual card number in 1 click at checkout
  privacy-badger  #privacy-badger17  # Block trackers
  privacy-pass     # Skip captchas/etc. in privacy-respecting way
  #privacy-possum  # falsify tracking data (pair w/ adnauseam)
  #privacy-redirect  # Redirect sites to privacy-respecting alternatives
  #privacy-settings  # Central location for privacy-related settings
  #privacy-relay
  #profile-switcher  # Switch FF profiles (requires connector)
  #redirector   # custom URL redirects
  skip-redirect
  smart-referer
  ubo-scope

  # --- Block Annoyances ----
  #behind-the-overlay-revival  # Close popup overlays
  buster-captcha-solver
  #consent-o-matic
  #i-dont-care-about-cookies
  ninja-cookie   # Remove cookie banners & reject non-essential

  # --- Desktop Integration -
  #ff2mpv
  #ghosttext
  gnome-shell-integration
  gsconnect
  #notion-web-clipper
  #open-in-browser
  #org-capture  # Emacs org-mode site capture
  #plasma-integration
  #pywalfox
  #textern

  # --- Development ---------
  #a11ycss
  #enhanced-github
  #gitpod
  #gloc
  #header-editor
  #hoppscotch
  lovely-forks
  #modheader  #modheader-firefox  # Modify request headers
  #octolinker
  #octotree
  #sourcegraph  #sourcegraph-for-firefox
  react-devtools
  #reduxdevtools
  #refined-github  #refined-github-
  #vue-js-devtools
  #wappalyzer  # Analyze technologies on sites

  # --- Downloading ---------
  #ipfs-companion
  #markdownload  # Markdown web clipper
  #musescore-downloader
  #no-pdf-download
  #pinboard  # Pinboard.in clipper for notes
  #save-page-we
  #single-file
  #video-downloadhelper
  wayback-machine  #wayback-machine_new

  # --- Email ---------------
  #anonaddy
  #mailvelope
  #simplelogin

  # --- Keyboard Shortcuts --
  #firenvim
  #gesturefy
  #linkhints
  #surfingkeys #surfingkeys_ff
  #tridactyl  #tridactyl-vim
  #vim-vixen
  #vimium-c
  #vimium  #vimium-ff

  # --- Password Managers ---
  bitwarden #bitwarden-password-manager
  #browserpass  #browserpass-ce
  #gopass-bridge
  #keepass-helper #keepass-helper-url-in-title  #keepass-helper
  #keepassxc-browser
  #lesspass
  #okta-browser-plugin

  # --- Productivity --------
  #leechblock-ng

  # --- Search --------------
  #add-custom-search-engine
  #c-c-search-extension
  #duckduckgo-privacy-essentials #duckduckgo-for-firefox
  #ecosia #ecosia-the-green-search
  #js-search-extension
  #rust-search-extension
  #search-engines-helper
  #search-by-image #search_by_image
  #startpage-private-search
  #ublacklist

  # --- Social --------------
  #betterttv
  #facebook-container
  #fediact  # Simplifies interactions on other Mastodon instances
  #keybase  #keybase-for-firefox   #keybase
  #old-reddit-redirect
  #reddit-enhancement-suite
  #reddit-moderator-toolbox
  #reddit-comment-collapser  #reddit_comment_collapser
  #streetpass-for-mastodon

  # --- Sync ----------------
  floccus
  #xbs  #xbrowsersync

  # --- Tabs ----------------
  #adsum-notabs
  #auto-tab-discard
  #close-other-windows
  export-tabs-urls-and-titles
  #onetab
  #new-window-without-toolbar
  #nighttab
  #sidebery   # Super nice tab tree manager w/ containers, groups, more
  simple-tab-groups
  #tab-counter-plus
  #tab-reloader
  #tab-retitle
  tab-session-manager
  tab-stash
  #tab-unloader-for-tree-style-tab
  #tabcenter-reborn
  #tree-style-tab
  #tst-tab-search  #tst-search

  # --- NTP ------------------
  #momentumdash
  #new-tab-override
  #tabliss

  # --- Themes --------------
  #dark-mode-website-switcher
  #firefox-color
  #text-contrast-for-dark-themes

  # --- Translate -----------
  #firefox-translations
  #languagetool
  #to-deepl

  # --- Media ---------------
  #blocktube
  #df-youtube
  #enhancer-for-youtube
  #h264ify
  #peertubeify
  #view-image  # Adds search by image button back to Google Images
  #videospeed
  #web-scrobbler # Playback scrobbler for various sites
  #youchoose-ai
  #youtube-recommended-videos
  #youtube-shorts-block

  # --- History -------------
  #history-cleaner
  #promnesia  # Enhanced history

  # --- Misc ----------------
  #ether-metamask   #metamask
  #flagfox  # Show country flag of content
  #ipvfoo-pmarks   # View server IP address
  #laboratory-by-mozilla
  #limit-limit-distracting-sites
  #native-mathml
  #news-feed-eradicator
  #offline-qr-code-generator
  #rabattcorner  # Cashback
  #smart-refresher
  #statshunters  # Show tiles on maps/routing sites
  #switchyomega
  #temporary-containers

  # --- Censorship ---
  #snowflake #torproject-snowflake
  #user-agent-string-switcher
  #wallabagger

  #windscribe    # Free VPN & ad blocker
  #zoom-page-we
  #zoom-redirector
]
