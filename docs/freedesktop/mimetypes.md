# How to create new MIME Types

## Declaring New MIME Types

This allows your application to present itself as an opener for your filetypes.

Example: Audacity

from: `~/.local/share/flatpak/exports/share/mime/application/x-audacity-project+sqlite3.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<mime-type xmlns="http://www.freedesktop.org/standards/shared-mime-info" type="application/x-audacity-project+sqlite3">
  <sub-class-of type="application/vdn.sqlite3"/>
  <comment>Audacity project</comment>
  <glob pattern="*.aup3" weight="5"/>
</mime-type>
```

from: `~/.local/share/flatpak/exports/share/mime/packages/org.audacityteam.Audacity.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/x-audacity-project">
    <sub-class-of type="text/xml"/>
    <comment>Audacity project</comment>
    <glob pattern="*.aup" weight="5"/>
  </mime-type>
  <mime-type type="application/x-audacity-project+sqlite3">
    <sub-class-of type="application/vdn.sqlite3"/>
    <comment>Audacity project</comment>
    <glob pattern="*.aup3" weight="5"/>
  </mime-type>
</mime-info>
```

Questions:

- [ ] *Why doe these both coexist?*
- [ ] What is the difference between an **application** and **packages** w.r.t. MIME?


## Setting Default Openers for MIME Types

Example: Nautilus

```ini
[Default Applications]
inode/directory=nautilus.desktop;org.gnome.Nautilus.desktop
```
