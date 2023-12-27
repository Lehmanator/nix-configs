{ self, inputs
, config, lib, pkgs
, ...
}:
{
  # --- Telescope.nvim ---------------
  programs.nixvim.plugins.telescope = {
    enable = lib.mkDefault true;
    extensions = {

      # TODO: Create keybinds to launch
      frecency = {           # Search & list frequent/recent files & their tags
        enable = true;
        showUnindexed = true;
        showScores = true;

        ignorePatterns = [         "*/tmp/*"  # Prevent indexing: # Temporary files
          "*.git/*"   "*.svn/*"     "*.cvs/*"                      # Version control metadata
          "*.ssh/*"   "/etc/ssh/*"                                 # SSH keys
          "*.gnupg/*" "/etc/gnupg/*" config.programs.gpg.homedir   # GPG keys
          "*.luks/*"  "/etc/luks/*"                                # LUKS keys
          # TODO: agenix / sops-nix                                # age keys
          # TODO: Hashicorp Vault                                  # Hashicorp Vault
        ]; # TODO: Conditionally enable dirs & read dirs from Nix config

        workspaces = {                  # Workspaces isolate indexed tags to their directories
          nixos   = "${config.xdg.configHome}/nixos";
          nix-std = "${config.xdg.userDirs.extraConfig.XDG_CODE_DIR}/infra";
          config  = config.xdg.configHome;
          data    = config.xdg.dataHome;
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
      media_files = {    # Preview media filetypes in Telescope.nvim. Uses chafa, ImageMagick fd/rg/find, ffmpegthumbnailer, pdftoppm, epub-thumbnailer, fontpreview
        enable = true;
        find_cmd = if config.programs.rg.enable then "rg" else if config.programs.fd.enable then "fd" else "grep";
        filetypes = [
          "png" "webp" "jpg"  "jpeg" "gif" "bmp"       # Images       # TODO: Rendered SVGs
          "mp4" "webm" "3gp"                           # Videos       #
          "pdf" "epub" "djvu" "mobi"                   # Documents    # TODO: Rendered Markdown, HTML?
          #"mp3" "m4a"  "flac" "ogg"                    # Audio files? # TODO: show metadata?
          #"log"                                        # Log files    # TODO: Pretty-printed log files
          #"pub" "p11"  "pkcs" "cert" "crt" "tls" "pem" # Crypto keys  # TODO: show metadata
          # TODO: 3D models?
          # TODO: Archives
          # TODO: Binaries / packages
          # TODO: Fonts
        ];  # TODO: Possible to incorporate lesspipe.sh ?
      };

      project-nvim = {
        enable = config.programs.nixvim.plugins.project-nvim.enable;
      };
    };
    #defaults = {};
    #extraOptions = {};
    #highlightTheme = nulll;
    #keymaps = { "<C-p>" = "git_files";
    #  "<leader>fg" = "live_grep"; };
  };
}
