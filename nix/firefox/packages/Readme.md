# //firefox/packages

Packages related to Firefox & its configuration.

## Firefox Wrappers

Firefox package wrapped with configs, add-ons, policies, settings, data, etc.

Allows user to use a firefox package that comes pre-wrapped with a config.
Allows usage via `nix install profile github:Lehmanator/nix-configs#firefox-wrapped-<configName>`

## Firefox Configuration Packages

Package Firefox config as standalone packages.
Allows user to use `pkgs.symlinkJoin` to merge multiple configurations.
Allows wrapping Firefox package with config.

Target browsers to wrap with configurations:

- Firefox
- LibreWolf
- IceRaven
- ArkenFox
- Tor Browser

Package Names:

- `<browser>-data-<profile>`: Miscellaneous data that isn't a setting.
- `<browser>-policies-<profile>`: Policies (usually set system-wide)
- `<browser>-settings-<profile>`: Settings
- `<browser>-config-<profile>`: Complete configurations (data+policies+settings+add-ons)

### List: Configuration Profiles

- [ ] TODO: `homeProfiles.firefox-default`
- [ ] TODO: `homeProfiles.firefox-gnome`
- [ ] TODO: `homeProfiles.firefox-kde`
- [ ] TODO: `homeProfiles.firefox-hardened`

- [ ] TODO: `packages.firefox-config-default`
- [ ] TODO: `packages.librewolf-config-default`
- [ ] TODO: `packages.tor-config-default`
- [ ] TODO: `packages.firefox-config-gnome`
- [ ] TODO: `packages.librewolf-config-gnome`
- [ ] TODO: `packages.tor-config-gnome`
- [ ] TODO: `packages.firefox-config-kde`
- [ ] TODO: `packages.librewolf-config-kde`
- [ ] TODO: `packages.tor-config-kde`
- [ ] TODO: `packages.firefox-config-hardened`
- [ ] TODO: `packages.librewolf-config-hardened`
- [ ] TODO: `packages.tor-config-hardened`

## Firefox Add-ons

Prefix: `firefox-addon-` (for `WebExtension` add-ons)
Prefix: `firefox-addon-theme-` (for theme add-ons)
Prefix: `firefox-addon-<addonName>-settings-` (for add-on settings)

Packages for Firefox add-ons.
Can be either `WebExtensions` or Firefox themes.
This cell mostly includes add-ons that are not already packaged upstream
either in `nixpkgs`
or in `nur.repo.ryantm.firefoxAddons`.

- [ ] TODO: Move existing packages from other `std` cells.
- [ ] TODO: `lib.firefox-wrap-with-system`
- [ ] TODO: `lib.firefox-wrap-with-home`
- [ ] TODO: `lib.firefox-wrap-with-env`

### List: Firefox Add-ons

- [ ] [ankiTab](./addon-anki-tab.nix)
  - [ ] TODO: Convert to `lib.firefoxAddonAPI` (or whatever)
- [ ] [anki-dict-helper](./addon-anki-dict-helper.nix)
  - [ ] TODO: Convert to `lib.firefoxAddonAPI` (or whatever)

## Styles

Packages for styles for Firefox that do not come packaged as Firefox theme add-ons.

### `userChrome.css`

Prefix: `firefox-userchrome-`

CSS styles for Firefox browser chrome that get merged/imported into `userChrome.css`.

- [ ] TODO: Create lib/pkg to build `userChrome.css` from list of imported packages.
- [ ] [GitHub: `rafaelmardojai/firefox-gnome-theme`](https://github.com/rafaelmardojai/firefox-gnome-theme)
  - [ ] TODO: Move from `cells.hive`
- [ ] [GitHub: `firefox-sidebar`]()
  - [ ] TODO: Move from `cells.hive`
- [ ] [GitHub: `firefox-csshacks`]()
  - [ ] TODO: Move from `cells.hive`

### `userContent.css`

Prefix: `firefox-usercontent-`

CSS styles for Firefox browser content that get merged/imported into `userContent.css`.

- [ ] Create lib/pkg to build `userContent.css` from list of imported packages.

### userStyles

Prefix: `userstyle-`

Custom user stylesheets to be used by `Stylix` add-on.
These are usually website-specific & browser-agnostic.

## userScripts

Prefix: `userscript-`

Custom user scripts to be used by `FireMonkey` or `ViolentMonkey` add-ons
User scripts alter the behavior of some set of websites by loading custom
javascript code.
User script code is loaded before scripts normally loaded by the website,
which can be used to block or patch the existing behavior of the site's JS.
These are usually website-specific & browser-agnostic.

## Utils

Utilities for working with Firefox & Firefox data.

- [ ] Password manager exporter
- [ ] Password manager sync
