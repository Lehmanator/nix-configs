# Social Apps

Configs:

- `../../hm/profiles/gnome/apps/social.nix`

## Client Types

### Native

- GTK + Libadwaita
- GTK + Libgranite
- Qt
- Iced

### Universal

- Electron
- Tauri
- Flutter

### Fallback

- Android Apps installed inside Waydroid
- Pidgin / Libpurple integration
- Matrix bridges / AppServices
- Non-native apps wrapped with themes & configs to make appear more native on other platforms.

#### Web Apps

Launcher Export Location: ~/.local/share/applications/net.codelogistics.webapps.${appId}.desktop
Data Location: `~/.var/app/net.codelogistics.webapps/webapps/${appId}.json`
Icon Location: `~/.var/app/net.codelogistics.webapps/icons/192x192/net.codelogistics.webapps.${appId}.png`

```json
{
  "name": "Nix Packaging",
  "url": "https://ryantm.github.io/nixpkgs/builders/trivial-builders/#chap-trivial-builders/",
  "icon": "Default Favicon",
  "show_navigation": false,
  "domain_matching": 0,
  "loading_bar": true,
  "javascript": true,
  "incognito": false,
  "app_id": "07646c14-3935-439c-9333-be41e4c0811e"
}
```

```nix
mkWebAppDesktop = name: icon: appId: ''
  [Desktop Entry]
  Name=${name}
  Icon=${icon}
  Terminal=false
  Type=Application
  Categories=Network;WebApps;
  Exec=flatpak run net.codelogistics.webapps ${appId}
  TryExec=/var/lib/flatpak/exports/bin/net.codelogistics.webapps
'';
```

- [ ] TODO: Handle MimeTypes
- [ ] TODO: Handle protocols
- [ ] TODO: Handle notifications


## Platforms

### Fediverse

- Matrix
- Mastodon
- Lemmy
- PixelFed
- Friendica
- Nostr
- Akkoma
- Misskey

### Proprietary

#### No Clients

- Bumble
- Facebook
- Facebook Messenger
- Hacker News
- Instagram
- Snapchat
- Tinder
- Tumblr
- WeChat
- Weibo

## To-Do

- [ ] Where to find PackageKit / AppStream data?
- [ ] Figure out how to hide applications from certain desktops

### `homeModules`

- [ ] Extend module to add options for `accounts.<service>`

### `homeProfiles`

- [ ] Create protocol handler for Mastodon?
- [ ] Assign Matrix protocol handler to client?: `matrix://`

- [ ] Create mapping of desktop environment / window manager -> GUI toolkit priority
- [ ] Create mapping of client apps -> GUI toolkit
- [ ] Create mapping of client apps -> flatpak appId & nixpkgs package name
- [ ] Create mapping of services -> webpage URLs
- [ ] Install packages for CLI / TUI chat / social clients
- [ ] Install appropriate clients for all installed desktops
- [ ] Hide clients using non-native toolkit from desktops
  - [ ] Qt apps from GNOME
  - [ ] GTK apps from KDE Plasma

- [ ] Integrate services with Pidgin
- [ ] Create standalone web apps for services without clients

Hide apps from non-native desktops:

Wrap the `.desktop` file exported by the package.

```ini
OnlyShowIn="gnome,phosh"
NotShowIn="plasma"
```
