{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    # --- zsh-abbr ---
    # Like aliases, but can expand in-place.
    # TODO: Import git aliases
    # - NOTE: Can use CLI `abbr import-git-aliases -g --prefix "git "
    # TODO: Import zsh regular aliases
    # - NOTE: Can use: `abbr import-aliases`
    # TODO: Import zsh global aliases
    zsh-abbr = {
      enable = true;
      #abbreviations = let
      #  # Maps git aliases, but prefixed with "git " first
      #  git-aliases = lib.attrsets.mapAttrs' (n: v: "git ${n}" "git ${v}") config.programs.git.aliases;
      #  // lib.attrsets.mapAttrs' (n: v: "g ${n}" "git ${v}") config.programs.git.aliases
      #  aliases = config.home.shellAliases // config.programs.zsh.shellAliases
      #  global-aliases = config.programs.zsh.shellGlobalAliases =
      #in config.programs.zsh.shellGlobalAliases // {};
    };

    # --- Global Aliases ---
    # These aliases can be expanded anywhere in line
    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)"; # Substitute newly-generated UUID
      XARGS = "| xargs"; # #

      # Searching
      GREP = "| grep"; # # Pipe to environment grep
      RG = "| rg"; # # Pipe to ripgrep file text searcher

      # File Viewing
      CAT = "| cat"; # # Pipe to cat
      LO = "| lessopen"; # # Pipe to user-set pager util
      PAGER = "| $PAGER"; # # Pipe to user-set pager util
      PG = "| $PAGER"; # # Pipe to user-set pager util

      # Fuzzy Search
      # TODO: With file/dir previewer
      FZF = "| fzf";

      # Path substitution
      #PATH_FILE = "$(realpath $CWD)"; # #
      CWD = "$(pwd)"; # # Substitute current directory path
      CWD_REL_HOME = "$(pwd | realpath --relative-to=$HOME)";
      CWD_REL_PARENT = "$(pwd | realpath --relative-to='..')";

      # Easily add string to Nix commands
      NIXOS_BUILD_TARGET = "#nixosConfigurations.${osConfig.networking.hostName}.config.system.build.toplevel";
      NIX_CLI_DEBUG_FLAGS = "--show-trace -vvv";

      # Short parent directories
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };

    # --- Regualar Aliases ---
    # Only for zsh-specific shell aliases
    # Generic aliases should go in `../common/alias.nix`
    shellAliases = {pretty-fpath = "echo \"$fpath\" | tr ' ' '\\n'";};
  };
}
