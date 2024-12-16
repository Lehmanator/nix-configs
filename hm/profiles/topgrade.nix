{ config, lib, pkgs, osConfig, ... }:
{
  # --- Package Management & Task Running ---
  # TODO: [topgrade](https://github.com/r-darwish/topgrade/wiki/Step-list)
  programs.topgrade = {
    enable = true;
    package = pkgs.topgrade;

    # https://github.com/topgrade-rs/topgrade/blob/main/config.example.toml
    settings = { 
      include.paths = ["/etc/topgrade.toml"];

      # --- System ---------------------
      flatpak.use_sudo = false;
      firmware.upgrade = true;

      # --- Nix ------------------------
      # linux.nix_env_arguments = "--prebuilt-only";
      linux.nix_arguments          = "--flake ~/Nix/configs"; # "~/.config/nixos"];
      linux.home_manager_arguments = ["--flake" "~/Nix/configs"]; # "~/.config/nixos"];

      # --- Git ------------------------
      git = {
        max_concurrency = 5;
        pull_predefined = false;
        arguments = "--rebase --autostash";

        # TODO: Move personal repos to hm/users/sam/topgrade.nix
        repos = [
          "~/Nix/clan"
        ];
      };

      # --- Containers -----------------
      containers.runtime = lib.mkIf config.services.podman.enable "podman";
      

      # --- Extra Commands -------------
      # "name item" = "command";
      commands = { };
      pre_commands = { };
      post_commands = { };

      misc = {
        assume_yes = true;
        no_retry = true;
        cleanup = true;

        # --- Ignoring -----------------
        # only = [];
        disable = [];
        ignore_failures = [];
        no_self_update = true;

        # --- Notification -------------
        notify_each_step = false;
        skip_notify = false;

        # --- Terminal -----------------
        display_time = true;
        set_title = true;
        tmux_arguments    = lib.mkIf config.programs.tmux.enable "-S /var/tmux.sock";
        tmux_session_mode = lib.mkIf config.programs.tmux.enable "attach_if_not_in_session"; # "attach_always"
        run_in_tmux       =          config.programs.tmux.enable;

        # --- Privilege Escalation -----
        # Run `sudo -v` to cache credentials at the start of the run
        # This avoids a blocking password prompt in the middle of an unattended run
        # (default: false)
        pre_sudo = true;

        # Command to get elevated privileges
        # TODO: Handle MacOS
        # TODO: Handle system-manager
        # TODO: Handle unmanaged system
        # TODO: Handle systemd-run
        # TODO: Handle pkexec?
        sudo_command = let
          hasPlease = (lib.attrByPath ["security" "please"  "enable"] false osConfig);
          hasSudo   = (lib.attrByPath ["security" "sudo"    "enable"] false osConfig)
                   || (lib.attrByPath ["security" "sudo-rs" "enable"] false osConfig);
        in lib.mkIf (hasSudo || hasPlease) (if hasPlease then "please" else "sudo");

        # --- Remote Hosts -------------
        # List of remote machines with Topgrade installed on them.
        remote_topgrades = [];
        ssh_arguments = "-o ConnectTimeout=5";
      };
    };
  };

  home.shellAliases.up = "topgrade";
}
