{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../../games
    #../../games/streaming.nix
  ];

  home.packages =
    let
      obs-plugins = with pkgs.obs-studio-plugins; [
        advanced-scene-switcher
        droidcam-obs
        input-overlay # Show gamepad, etc inputs in OBS Studio  #pkgs.nur.repos.deeunderscore.obs-input-overlay # show gamepad inputs, etc in OBS Studio
        looking-glass-obs
        waveform
        wlrobs

        obs-3d-effect
        obs-backgroundremoval
        obs-command-source
        obs-gradient-source
        obs-gstreamer
        obs-hyperion
        obs-livesplit-one
        obs-move-transition
        obs-multi-rtmp
        obs-mute-filter
        obs-ndi
        obs-rgb-levels-filter
        obs-scale-to-sound
        obs-shaderfilter
        obs-source-clone
        obs-source-record
        obs-source-switcher
        obs-teleport
        obs-text-pthread
        obs-transition-table
        obs-tuna
        obs-vaapi
        obs-vertical-canvas
        obs-vintage-filter
        obs-vkcapture
        obs-websocket

        #lib.lists.optional config.services.pipewire.enable
        obs-pipewire-audio-capture
      ];
    in
    [
      pkgs.ffmpeg_6-full

      pkgs.nur.repos.mic92.noise-suppression-for-voice
      pkgs.nur.repos.kira-bruneau.replay-sorcery # Enable saving game replays

      pkgs.obs-studio
      pkgs.obs-cli
    ] ++ obs-plugins;

}
