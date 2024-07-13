{ cell, config, osConfig, lib, pkgs, ... }: {
  #imports = [cell.homeProfiles.device-nintentdo-switch];

  # TODO: Terminal/zsh/tmux plugins?
  # TODO: Configure Vim plugin: vimsence
  # TODO: Configure OBS
  # TODO: Configure VMs for OBS

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      #pkgs.nur.repos.deeunderscore.obs-input-overlay
      advanced-scene-switcher
      droidcam-obs
      input-overlay                # Show gamepad, etc inputs in OBS Studio
      looking-glass-obs            # TODO: Conditional looking-glass enabled
      waveform
      wlrobs                       # TODO: Conditional wlroots-based compositor enabled
      obs-3d-effect
      obs-backgroundremoval
      obs-command-source
      obs-composite-blur
      obs-freeze-filter
      obs-gradient-source
      obs-gstreamer                # TODO: Conditional gstreamer enabled
      obs-hyperion
      obs-livesplit-one
      obs-move-transition
      obs-multi-rtmp
      obs-mute-filter
      obs-ndi # Network A/V
      obs-nvfbc # NVIDIA FBC API  # TODO: Conditional based on GPU
      obs-pipewire-audio-capture
      obs-replay-source
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
      obs-vaapi               # TODO: Conditional VAAPI enabled
      obs-vertical-canvas
      obs-vintage-filter
      obs-vkcapture           # TODO: Conditional Vulkan/OpenGL drivers enabled
      obs-websocket
      obs-webkitgtk
    ];
  };

  home.packages = [
    pkgs.ffmpeg-full
    # pkgs.libav_12 # ffmpeg fork
    pkgs.nur.repos.mic92.noise-suppression-for-voice
    pkgs.nur.repos.kira-bruneau.replay-sorcery # Enable saving game replays
    pkgs.vimPlugins.vimsence # Discord presence plugin for Vim
    pkgs.obs-cli
    pkgs.obs-do
  ]; # ++ lib.optional osConfig.services.pipewire.enable pkgs.obs-studio-plugins.obs-pipewire-audio-capture
}
