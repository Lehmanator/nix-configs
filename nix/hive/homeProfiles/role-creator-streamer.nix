{ inputs, config, osConfig, lib, pkgs, ... }: {
  #imports = [
  #  inputs.self.homeProfiles.device-nintentdo-switch
  #];

  home.packages = [
    pkgs.ffmpeg-full
    pkgs.libav_12 # ffmpeg fork

    pkgs.nur.repos.mic92.noise-suppression-for-voice
    pkgs.nur.repos.kira-bruneau.replay-sorcery # Enable saving game replays

    pkgs.vimPlugins.vimsence # Discord presence plugin for Vim

    pkgs.obs-studio
    pkgs.obs-cli
    pkgs.obs-do
    pkgs.obs-studio-plugins.advanced-scene-switcher
    pkgs.obs-studio-plugins.droidcam-obs
    pkgs.obs-studio-plugins.input-overlay # Show gamepad, etc inputs in OBS Studio
    #pkgs.nur.repos.deeunderscore.obs-input-overlay
    pkgs.obs-studio-plugins.looking-glass-obs # TODO: Conditional looking-glass enabled
    pkgs.obs-studio-plugins.waveform
    pkgs.obs-studio-plugins.wlrobs # TODO: Conditional wlroots-based compositor enabled

    pkgs.obs-studio-plugins.obs-3d-effect
    pkgs.obs-studio-plugins.obs-backgroundremoval
    pkgs.obs-studio-plugins.obs-command-source
    pkgs.obs-studio-plugins.obs-composite-blur
    pkgs.obs-studio-plugins.obs-freeze-filter
    pkgs.obs-studio-plugins.obs-gradient-source
    pkgs.obs-studio-plugins.obs-gstreamer # TODO: Conditional gstreamer enabled
    pkgs.obs-studio-plugins.obs-hyperion
    pkgs.obs-studio-plugins.obs-livesplit-one
    pkgs.obs-studio-plugins.obs-move-transition
    pkgs.obs-studio-plugins.obs-multi-rtmp
    pkgs.obs-studio-plugins.obs-mute-filter
    pkgs.obs-studio-plugins.obs-ndi # Network A/V
    pkgs.obs-studio-plugins.obs-nvfbc # NVIDIA FBC API  # TODO: Conditional based on GPU
    pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    pkgs.obs-studio-plugins.obs-replay-source
    pkgs.obs-studio-plugins.obs-rgb-levels-filter
    pkgs.obs-studio-plugins.obs-scale-to-sound
    pkgs.obs-studio-plugins.obs-shaderfilter
    pkgs.obs-studio-plugins.obs-source-clone
    pkgs.obs-studio-plugins.obs-source-record
    pkgs.obs-studio-plugins.obs-source-switcher
    pkgs.obs-studio-plugins.obs-teleport
    pkgs.obs-studio-plugins.obs-text-pthread
    pkgs.obs-studio-plugins.obs-transition-table
    pkgs.obs-studio-plugins.obs-tuna
    pkgs.obs-studio-plugins.obs-vaapi # TODO: Conditional VAAPI enabled
    pkgs.obs-studio-plugins.obs-vertical-canvas
    pkgs.obs-studio-plugins.obs-vintage-filter
    pkgs.obs-studio-plugins.obs-vkcapture # TODO: Conditional Vulkan/OpenGL drivers enabled
    pkgs.obs-studio-plugins.obs-websocket
    pkgs.obs-studio-plugins.obs-webkitgtk
  ]
    # ++ lib.optional osConfig.services.pipewire.enable pkgs.obs-studio-plugins.obs-pipewire-audio-capture
  ;

  # TODO: Terminal/zsh/tmux plugins?
  # TODO: Configure Vim plugin: vimsence
  # TODO: Configure OBS
  # TODO: Configure VMs for OBS
}
