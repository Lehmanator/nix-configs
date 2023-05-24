{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  # TODO: Fix white '^^^^^^^^' in statusline (set to BG or NONE)
  programs.nixvim.highlight = {
    #IndentBlanklineIndent2.ctermfg = "bg";
    #IndentBlanklineIndent1 = { fg = "NONE"; ctermfg = "NONE"; };
    lualine_c_active.bg = "NONE";
    lualine_c_inactive.bg = "NONE";
    lualine_x_active.bg = "NONE";
    lualine_x_inactive.bg = "NONE";
    lualine_x_normal.bg = "NONE"; #lualine_x_normal.bg = "NONE";
    lualine_c_normal.bg = "NONE"; #lualine_c_normal.bg = "NONE";
    lualine_x_insert.bg = "NONE"; #lualine_x_insert.bg = "NONE";
    lualine_c_insert.bg = "NONE"; #lualine_c_insert.bg = "NONE";
    TabLineFill.bg = "NONE";
    TabLineFill.fg = "NONE";
    StatusLine.bg = "NONE";
    StatusLineNC.bg = "NONE";
    StatusLine.fg = "NONE";
    StatusLineNC.fg = "NONE";
  };

  # --- Statuslines ------------------
  programs.nixvim.plugins = {
    barbar = {
      enable = false;
      animation = true;
      autoHide = false;
      clickable = true;
      excludeFileNames = [ ];
      excludeFileTypes = [ ];
      extraOptions = { };
      hide.alternate = true;
      hide.current = false;
      hide.extensions = false;
      highlightAlternate = false;
      highlightInactiveFileIcons = false;
      highlightVisible = true;
      icons = {
        current = {
          pinned.separator = { left = "▎"; right = ""; }; # TODO: Conditionally use rounded
          separator = { left = ""; right = ""; }; # TODO: Conditionally use rounded
        };
        diagnostics = {
          error.enable = true;
          warn.enable = false;
        };
      };
    };

    lualine = {
      enable = true;
      alwaysDivideMiddle = true;
      extensions = [ "fzf" ];
      globalstatus = true;
      sectionSeparators = {
        left = "";
        right = "";
      };
      # TODO: Invert highlight
      componentSeparators = {
        left = ""; # "";
        right = ""; # ";
      };
      tabline = {
        # Top of editor
        lualine_a = [{ name = "hostname"; separator = { left = ""; right = ""; }; }];
        lualine_b = [ "branch" "diff" ];
        lualine_x = [{ name = "tabs"; extraConfig = { use_mode_colors = true; }; }];
        lualine_z = [ "diagnostics" ];
      };
      winbar = {
        # Top of splits
        lualine_a = [{ name = "mode"; separator = { left = ""; right = ""; }; }];
        lualine_b = [ "diff" ];
        lualine_c = [{ name = "windows"; extraConfig = { use_mode_colors = true; }; }];
        lualine_x = [ "branch" "diff" ];
        lualine_y = [ "searchCount" ];
        lualine_z = [ "selectionCount" ];
      };
      sections = {
        lualine_a = [
          { name = "mode"; separator = { left = ""; right = ""; }; }
        ];
        lualine_b = [
          #{ name = "branch";
          #}
          "branch"
          "diff"
        ];
        lualine_c = [
          { name = "buffers"; extraConfig = { use_mode_colors = true; mode = 0; }; }
          #{ name="filetype"; extraConfig={colored=true; icon_only=true; icon.align="left";};}
          #{ name="filename"; extraConfig={file_status=true; newfile_status=true; shorting_target=45; path = 4;
          #  symbols={modified="~"; readonly="!"; unnamed="?"; newFile="+";};};
          #}
          #"fileformat"
          #{ name = "fileformat"; extraConfig={symbols={unix=""; dos=""; mac="";}; icon.align="left";};}
        ];
        lualine_x = [
          #{ name="tabs";
          #  separator = { left = ""; right = ""; };
          #  extraConfig={mode=2; use_mode_colors=true; tabs_color={active="lualine_a_normal"; inactive="lualine_b_normal";};}; }
          "diagnostics"
          #{ name = "diagnostics";
          #}
        ];
        lualine_y = [
          "searchcount"
          "progress"
          #{ name = "progress";
          #}
        ];
        lualine_z = [
          {
            name = "location";
            separator = { left = ""; right = ""; };
          }
        ];
      };
    };

    tagbar = {
      enable = false;
      extraConfig = { show_tag_count = true; };
    };

  };
}
