{ inputs
, config
, lib
, pkgs
, osConfig ? {}
, ...
}:
let
  hasAlsa = 
    (lib.attrByPath ["services" "pipewire" "alsa" "enable"] false osConfig) ||
    (lib.attrByPath ["services" "jack"     "alsa" "enable"] false osConfig) ||
    ((lib.attrByPath ["sound" "enableOSSEmulation" ] false osConfig) && (lib.attrByPath ["sound" "enable"] false osConfig));
  hasIw = ((lib.attrByPath ["networking" "networkmanager" "wifi" "backend"] false osConfig) == "iwd") ||
    lib.attrByPath ["networking" "wireless" "iwd" "enable"] false osConfig;
in
{
  services.polybar = {
    enable = lib.mkDefault true;

    package = pkgs.polybarFull.override {
      alsaSupport = hasAlsa;
      githubSupport = config.programs.git.enable;
      iwSupport = hasIw;
      i3Support = true;
      mpdSupport = true;
      nlSupport = true;
      pulseSupport = true;
    };

    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:eDP1}";
        width = "100%";
        height = "3%";
        radius = 0; # TODO: Pass user style preferences
        modules-center = "date";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d %m"; #, %y";
        time = "%H:%M"; # TODO: AM/PM?
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
        ramp.volume = [ "🔈" "🔉" "🔊" ];
        click.right = "pavucontrol &";
      };
    };

    extraConfig = ''
    '';

  };
}
