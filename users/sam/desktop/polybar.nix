{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };

    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:eDP1}";
        width = "100%";
        height = "3%";
        radius = 0;                        # TODO: Pass user style preferences
        modules-center = "date";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d %m";             #, %y";
        time = "%H:%M";             # TODO: AM/PM?
        label = "%time% on %date%"; # "%date% @ %time%";
        #format-prefix-foreground = "\''${colors.foreground-alt}";
      };
    };

    # Script to start polybars. Set all necessary env vars here.
    script = ''
      polybar bar &
    '';

    settings = {
      "module/volume" = {
        type = "internal/pulseaudio";
        format.volume = "<ramp-volume> <label-volume>";
        label.muted.text = "🔇";
        label.muted.foreground = "#666";
        ramp.volume = ["🔈" "🔉" "🔊"];
        click.right = "pavucontrol &";
      };
    };

    extraConfig = ''
    '';

  };
}
