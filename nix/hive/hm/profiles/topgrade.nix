{ config, lib, pkgs, ... }: {
  # topgrade - Util to update all software
  # Options: https://github.com/topgrade-rs/topgrade/blob/main/config.example.toml
  # TODO: Configure myrepos `programs.mr.settings`
  programs.topgrade = {
    enable = true;
    settings = {
      include.paths = [ "/etc/topgrade.toml" ];

      assume_yes = true;
      cleanup = true;
      notify_each_step = true;
      run_in_tmux = false;
      set_title = true;
      skip_notify = false;
      misc = { pre_sudo = true; };

      pre_commands = { };
      post_commands = { };

      # --- Updaters -----------------------------------------------------------
      commands = {
        # TODO: ADB launch F-Droid app activity to update Android apps
        # TODO: SSH / KDEConnect run Termux `pkg update`
        # TODO: Commands to backup settings / data of various programs
        # TODO: Helm upgrades
        # TODO: Ollama server LLM upgrades
        "Nix garbage collection" = "nix-collect-garbage";
        #"Nix configuration package sources" = "nvfetcher";
      };
      #containers = {
      #  containers = ["archlinux-latest"];
      #  ignored_containers = ["ghcr.io/rancher-sandbox/rancher-desktop/rdx-proxy:latest" "docker.io"];
      #};
      distrobox.use_root = true;
      firmware.upgrade = true;
      flatpak.use_sudo = true;
      home_manager_arguments = [ "--flake" "file" ];
      nix_arguments = "--flake";
      nix_env_arguments = "--prebuilt-only";
    };
  };
}
