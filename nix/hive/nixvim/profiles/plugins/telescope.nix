{
  config,
  homeConfig,
  lib,
  pkgs,
  ...
}: let
  configHome = "~/.config"; # homeConfig.xdg.configHome or "~/.config";
  dataHome = "~/.local/share"; # homeConfig.xdg.dataHome or "~/.local/share";
  extraDirs =
    #homeConfig.xdg.userDirs.extraConfig or
    {
      XDG_CODE_DIR = "$HOME/Code";
    };
in {
  plugins.telescope = {
    enable = lib.mkDefault true;
    extensions = {
      # TODO: Create keybinds to launch
      frecency = {
        # Search & list frequent/recent files & their tags
        enable = true;
        showUnindexed = true;
        showScores = true;

        ignorePatterns = [
          "*/tmp/*" # Prevent indexing: # Temporary files
          "*.git/*"
          "*.svn/*"
          "*.cvs/*" # Version control metadata
          "*.ssh/*"
          "/etc/ssh/*" # SSH keys
          "*.gnupg/*"
          "/etc/gnupg/*" # config.programs.gpg.homedir   # GPG keys
          "*.luks/*"
          "/etc/luks/*" # LUKS keys
          # TODO: agenix / sops-nix                                # age keys
          # TODO: Hashicorp Vault                                  # Hashicorp Vault
        ]; # TODO: Conditionally enable dirs & read dirs from Nix config

        workspaces = {
          # Workspaces isolate indexed tags to their directories
          nixos = "${configHome}/nixos";
          nix-std = "${extraDirs.XDG_CODE_DIR}/infra";
          config = configHome;
          data = dataHome;
        };
      };

      fzf-native = {
        enable = true;
        caseMode = "smart_case";
        fuzzy = true;
        #overrideFileSorter = false;
        #overrideGenericSorter = false;
      };
      #fzy-native.enable = true;
      media_files = {
        # Preview media filetypes in Telescope.nvim. Uses chafa, ImageMagick fd/rg/find, ffmpegthumbnailer, pdftoppm, epub-thumbnailer, fontpreview
        enable = true;
        #find_cmd = if homeConfig.programs.rg.enable then "rg" else if homeConfig.programs.fd.enable then "fd" else "grep";
        find_cmd = lib.getExe pkgs.ripgrep;
        filetypes = [
          "png"
          "webp"
          "jpg"
          "jpeg"
          "gif"
          "bmp" # Images       # TODO: Rendered SVGs
          "mp4"
          "webm"
          "3gp" # Videos       #
          "pdf"
          "epub"
          "djvu"
          "mobi" # Documents    # TODO: Rendered Markdown, HTML?
          #"mp3" "m4a"  "flac" "ogg"                    # Audio files? # TODO: show metadata?
          #"log"                                        # Log files    # TODO: Pretty-printed log files
          #"pub" "p11"  "pkcs" "cert" "crt" "tls" "pem" # Crypto keys  # TODO: show metadata
          # TODO: 3D models?
          # TODO: Archives
          # TODO: Binaries / packages
          # TODO: Fonts
        ]; # TODO: Possible to incorporate lesspipe.sh ?
      };

      project-nvim = {
        enable = lib.mkDefault config.plugins.project-nvim.enable;
      };
    };
    #defaults = {};
    #extraOptions = {};
    #highlightTheme = nulll;
    #keymaps = { "<C-p>" = "git_files";
    #  "<leader>fg" = "live_grep"; };
  };
}
