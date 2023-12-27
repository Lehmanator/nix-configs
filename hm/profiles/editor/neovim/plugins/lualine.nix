{ inputs
, lib
, ...
}:
{
  programs.nixvim.plugins.lualine = {
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
}
