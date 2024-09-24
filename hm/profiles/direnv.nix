{ inputs
, config, lib, pkgs
, ...
}:
{
  # --- nix-direnv ---------------------------------------------------
  # TODO: Nushell integration (https://github.com/nushell/nu_scripts)
  #   Add hook to `$env.config.hooks.env_change.PWD` list in `config.nu`:
  #   Hook contents in file: https://github.com/nushell/nu_scripts/blob/main/nu-hooks/nu-hooks/direnv/config.nu
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };

    # Config in $XDG_CONFIG_HOME/direnv/direnv.toml
    #  Options: `$ man direnv.toml(1)`
    config = {
      global = {
        bash_path = "${lib.getExe pkgs.bashInteractive}";
        disable_stdin = false;
        load_dotenv = true;
        strict_env = true;
        warn_timeout = "5s";
        hide_env_diff = false;
      };
      whitelist = {
        exact = ["~/Nix/config" "~/Nix/clan" "~/Nix/termux"];
        prefix = ["~/.config" "~/.local/share" "~/Code/lehmanator" "~/Projects/lehmanator"];
      };
    };
    # Custom stdlib written to $XDG_CONFIG_HOME/direnv/direnvrc
    # stdlib = ''
    # '';
  };
  
  # --- nix-index ----------------------------------------------------
  # nix-index: Locates package providing certain files in nixpkgs.
  #            Indexes built derivations found in binary caches.
  # nix-index-database: nix-index file database (nixos-unstable channel).
  #                     Pre-generated to avoid having to manually generate.
  #                     NOTE: updated weekly
  #                     NOTE: Only use if using nixos-unstable nixpkgs?
  # TODO: Nushell integration for `nix-index`
  # imports = [inputs.nix-index-database.hmModules.nix-index];
  # programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    package = pkgs.nix-index;
  };

  # --- Lorri --------------------------------------------------------
  # Lorri is a nix-shell replacement for project development.
  #  Based around fast direnv integration for robust CLI & editor integration
  services.lorri = {
    enable = true;                 # Lorri build daemon
    enableNotifications = true;    # Lorri build notifications
    package = config.nix.package;  # Share Nix/Lix package w/ CLI
  };

  home = {
    packages = [
      pkgs.comma                      # Wraps `nix shell -c` & `nix-index`
      pkgs.lorri                      # Lorri CLI
      config.programs.direnv.package  # Required to use Lorri service
      config.programs.direnv.nix-direnv.package
    ];
    shellAliases = {
      lorri-init  = "lorri init";
      lorri-watch = "lorri watch &";
    };
  };

  # --- Command-not-found --------------------------------------------
  # NOTE: nix-index provides `${pkgs.nix-index}/etc/profile.d/command-not-found.sh`
  # TODO: Nushell integration

  # TODO: Why did I initially add this config?
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
}
