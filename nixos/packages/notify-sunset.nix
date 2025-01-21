{ libnotify
, writeShellApplication
}:
# NOTE: To use with GNOME shell extensions, this package must be added to:
#   `services.xserver.desktopManager.gnome.sessionPath`
writeShellApplication {
  name = "notify-sunset";

  # TODO: Package for gsettings command?
  runtimeInputs = [ libnotify ];

  # TYPE: boolean | int | double | string | byte | variant
  # TODO: Weather in body?
  # TODO: Timestamp in body
  # TODO: Username in body?
  text = ''
    theme="$(
      notify-send 'Good evening!'     \
        --icon='daytime-sunset'       \
        --action='prefer-light=Light' \ 
        --action='prefer-dark=Dark'   \ 
        --action='default=Default'    \ 
        --app-name='Theme Switcher'   \
        --urgency=normal              \
        --expire-time=1000            \ 
        # --print-id                    \
        # --transient                   \
        # --category="<TYPE>..."        \
        # <BODY>
    )'"
    if [[ theme != "" ]]; then
      gsettings set org.gnome.desktop.interface color-scheme "'$theme'""'
    fi
  '';
}
