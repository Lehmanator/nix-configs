{ config, lib, pkgs
, user
, ...
}:
{
  # See: https://starship.rs/config/
  # https://starship.rs/advanced-config
  # Style: https://starship.rs/advanced-config/#style-strings
  # Icons: https://www.nerdfonts.com/cheat-sheet
  # - Mode:
  #   - Normal: 󱁐 , 󰌌 ,  , 󰌏 , 󰌐 , 󱊷 , 󰌥 , 󰌒 ,  , ❮ ,  ,  , 󱊷 , 
  #   - Insert:  , ❯ , ❯ , ❯ ,  ,  , 󰁔 ,  , ─ , ❯ , ❮ ,
  # - Status:
  #   - Error:      ✖ , ✖ , ❌, ✖ , ✖ , ✕ , ✗ , ✘ , ☒ ,☓ , 
  #   - Success:    󰸞 ,  ,  ,  ,  ,  ,  , ✅, ☑ ,
  #       Unicode:  ✔ , ✓ , ✔ , ✓ , ☑ ,  
  #       Emoji:    ✔️ , ✅, ☑️ , 
  # - Box Drawing:  └─, ─ , 
  # - Time:          , 󰔛 , 󱎫 , 󱦟 , 
  # - Readonly:      ,  , 󰈈 ,  , 󰷊 , 󱞊 , 🔒 , 🚫
  # - Delimiters:    ,  ,  ,  ,  , 
  # - Directories:
  #   - Home:      , 
  #   - Ellipsis:  ,  , … ,  , 
  #   - Settings:  ,  , 
  #   - Git:       , 󰊢 ,  ,  ,  ,  ,  , , 
  #   - GitHub:    , 󰊤 ,  ,  , 
  #   - Download:  , 󰇚 , 
  #   - Nix:     Unicode: ❆ , 
  #
  # TODO: Setup right prompt
  # TODO: Match prompt styles with statusline in Neovim / Helix config.
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings =  let
      # TODO Dynamically change `starship.character.vimcmd_*symbol`
      vim = { abbr=true; full=true; caps=true; normalize_width=true; };
      prefix = { top = "╭─"; bottom="╰󰁔"; style="dimmed white"; };
      sep = {
        left = { icon=""; style="bg:prev_bg fg:none"; };
        right= { icon=""; style="bg:none fg:prev_bg"; };
      };
    in {
      character = {
        format = "[${prefix.bottom}](${prefix.style}) $symbol [](dimmed white blink) "; #─[$](dimmed white blink)";
        error_symbol              = "[❌](dimmed red)";
        success_symbol            = "[ ](dimmed green)";
        vimcmd_symbol             = "[󱊷 ](dimmed white)";
        vimcmd_replace_one_symbol = "[r]─❮ ](bold purple)";
        vimcmd_replace_symbol     = "[R]─❮ ](bold purple)";
        vimcmd_visual_symbol      = "[V]─❮ ](bold orange)";
      };

      cmd_duration = {
        format = "󱦟 [$duration]($style)";  # Default: "took [$duration]($style)"
        # min_time = "2_000";
        # show_milliseconds = false;
        # style = "bold yellow";
        # show_notifications = false;
        # min_time_to_notify = "45_000";
        # notification_timeout = "45_000"; # time in milliseconds 
      };

      # TODO: Use box drawing chars for path slashes
      directory = {
        format = "[${prefix.top}](${prefix.style})[](bg:none fg:cyan)[$path]($style)[](bg:none fg:prev_bg)[$read_only]($read_only_style)";
        style = "bold bg:cyan fg:bright-black";
        before_repo_root_style = "bg:bright-black fg:white";
        repo_root_style = "bg:bright-cyan fg:purple bold";
        repo_root_format = "[${prefix.top}](${prefix.style})[](bg:none fg:bright-black)[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[](bg:none fg:cyan)[$read_only]($read_only_style) ";
        read_only_style = "bg:red fg:white bold";
        read_only = "🔒";
        truncation_symbol = " /";
        truncation_length = 8;
        truncate_to_repo = false;
        home_symbol = " ";
        use_os_path_sep = true;
        substitutions = {
          "${config.xdg.configHome}" = " / ";
          "~/.config/nixos" = "  (system)";
          "etc/nixos" = "  (system)";
          "etc" = " ";
          ".config" = " ";
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
          Nix = " ";  #    󱄅
          configs = " ";
          "/home/${user}/.local/repos" = "~/";
          "/home/${user}/.local/repos-all" = "~/";
        };
      };

      #palette = "testing";
      #palettes.testing = {
      #  blue = 21;
      #  mustard = "#af8700";
      #};

      follow_symlinks = true;

      fill = {
        symbol = "";
        style = "bold gray";
      };
    };
  };
}
