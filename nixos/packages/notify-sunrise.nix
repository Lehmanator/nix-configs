{ lib
, libnotify
, writeShellApplication
}:
writeShellApplication {
  name = "notify-sunrise";

  # TODO: Package for gsettings command?
  runtimeInputs = [ libnotify ];

  # TYPE: boolean | int | double | string | byte | variant
  text = ''
    notify-send "Good morning!" \
      --icon="daytime-sunrise" \
      --action="Set Dark Mode=gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'" \
      --app-name="Theme Switcher" \
      --category="<TYPE>..." \
      --urgency=low \
      --expire-time=1000 \
      --transient
  '';
}
