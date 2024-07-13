{ inputs, config, lib, pkgs, ... }: {
  # https://www.nushell.sh/book/configuration.html#configuration
  # https://www.nushell.sh/cookbook/external_completers.html#troubleshooting
  # https://github.com/nushell/awesome-nu/blob/main/plugin_details.md
  # https://nixos.wiki/wiki/Nushell
  #
    # TODO: Script to pretty print
    # - kubectl commands
    # - helm commands
    # - nix diff output
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    vscode.extensions = [pkgs.vscode-extensions.thenuprojectcontributors.vscode-nushell-lang];
    eza.enableNushellIntegration = lib.mkDefault true;
    yazi.enableNushellIntegration = lib.mkDefault true;

    nushell = {
      enable = true;
      package = pkgs.nushellFull;
      environmentVariables = {
        # EDITOR = if config.programs.helix.defaultEditor then "hx" else "nvim";
        #ENV_CONVERSIONS = {
        #  "MY_VARIABLE": {}
        #  # TODO: Use to colorize items in PATH & NIX_PATH based on executables inside
        #  "NIX_PATH": {}
        #  "PATH": {
        #    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        #    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        #  }
        #}
      };

      # --- Files ---
      configFile = {
        # source = path;
        text = ''
          plugin add ${lib.getExe pkgs.nushellPlugins.formats}
          plugin add ${lib.getExe pkgs.nushellPlugins.gstat}
          plugin add ${lib.getExe pkgs.nushellPlugins.net}
          plugin add ${lib.getExe pkgs.nushellPlugins.query}
          source nix-your-shell.nu
        '';
      };
      # envFile = {
      #   source=path;
      #   text=''
      #   '';
      # };
      # loginFile = {
      #   source=path;
      #   text=''
      #   '';
      # };

      # --- Extra Config ---
      # extraConfig = ''
      #   let carapace_completer = {|spans|
      #   carapace $spans.0 nushell $spans | from json
      #   }
      #   $env.config = {
      #     completions: {
      #       case_sensitive: false
      #       quick: true            # false=no auto-select
      #       partial: true          # false=no partial completing
      #       algorithm: "fuzzy"     # "prefix" | "fuzzy"
      #       external: {
      #         enable: true
      #         max_results: 300
      #         completer: $carapace_completer
      #       }
      #     }
      #   }
      # '';
      #extraEnv = '''';
      #extraLogin = '''';

      shellAliases = {
        e = "$env.EDITOR";
        l = "ls --du --mime-type | table -i false";
        ll = "ls -l --du --mime-type | table -i false";
        la = "ls --du --mime-type --all | table -i false";
        lla = "ls -l --du --mime-type --all | table -i false";
        commands = "help commands";
        helps = "help --find";
        h = "help";
        nixos-rebuild-debug = "sudo nixos-rebuild --show-trace --print-build-logs --verbose";
      };
    };
  };
  # xdg.configFile."nushell/nix-your-shell.nu".source = pkgs.runCommand "nix-your-shell-generate-nu-config" {} ''
  #    ${lib.getExe pkgs.nix-your-shell} nu
  # '';
  # xdg.configFile."nushell/nix-your-shell.nu".source = pkgs.nix-your-shell.generate-config "nu";
  
  # TODO: Are these loaded by default in home-manager?
  home.packages = [
    pkgs.nushellPlugins.formats
    pkgs.nushellPlugins.gstat
    pkgs.nushellPlugins.net
    pkgs.nushellPlugins.query
    pkgs.nu_scripts
    pkgs.nufmt
  ];

  # pkgs.snix-your-shell: nix / nix-shell wrapper for shells other than bash
  # file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
  #   pkgs.nix-your-shell.generate-config "nu";

}
