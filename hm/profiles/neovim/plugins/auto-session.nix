{ inputs, config, lib, pkgs, ... }:
{
  programs.nixvim.plugins.auto-session = {
    enable = true;
    #package = pkgs.vimPlugin.auto-session;
    #bypassSessionSaveFileTypes = [];
    #extraOptions = {};
    #logLevel = "error";
    #cwdChangeHandling = true;
    #autoSave = true;
    autoRestore.enabled = true;
    autoSession = {
      enabled = true;
      enableLastSession = true;
      createEnabled = true;
      useGitBranch = true;
      #allowedDirs = [];
      #rootDir = { __raw = "vim.fn.stdpath 'data' .. '/sessions/'"; };
      #suppressDirs = [];
    };
    sessionLens = {
      loadOnSetup = true;
      previewer = true;
      themeConf = { winblend = 10; border = true; };
      #sessionControl.controlDir = "vim.fn.stdpath 'data' .. '/auto_sessions/'";
      #sessionControl.controlFilename = "session_control.json";
    };
  };
}
