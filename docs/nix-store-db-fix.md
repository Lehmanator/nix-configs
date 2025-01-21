# GDM / Gnome-Shell crashing on Wayland

- Helix markdown broken format-on-save
- Git `warning: in the working copy of 'README.md', LF will be replaced by CRLF the next time Git touches it`
- Extension Manager app broken
- Enable Ollama UI
- Extra activationScript blocks
- kmscon + set terminal font
- Enable pipe operator
- Zsh substitute env vars in hook setting tab title (Fix: `$EDITOR <filepath>`)
  - Helix set tab title

## Fixes

- [ ] `autorandr.desktop`
- [ ] `fastfetch` call in `programs.zsh.loginExtra`
- [ ] `~/.config/gtk-4.0/gtk.css`
- [ ] `~/.config/gtk-3.0/gtk.css`
- [ ] Missing XDG portal?
- [ ] Missing `pkgs.gtop`
- [ ] `Extension gradienttopbar@pshow.org: Gio.IOErrorEnum: Error opening file “/run/current-system/sw/share/gnome-shell/extensions/gradienttopbar@pshow.org/user-stylesheet.css”: Read-only file system`
- [ ] `xkbcomp` - `Could not resolve keysym XF86KbdInputAssistNextgroup` 
  - [ ] `$XKEYBOARD`
- [ ] `Failed to execute child process "ibus-daemon (No such file or directory)"`
- [ ] Tabby server
- [ ] Cachix daemon
- [ ] Keyring
- [ ] wgautomesh
- [ ] `libvirtd` using `iptables`
- [ ] `notify-send: command not found`


### Solution

Disable On-Screen Keyboard (OSK) in GDM.
```sh
  sudo -u gdm dbus-run-session gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
```
