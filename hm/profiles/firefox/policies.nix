{ config, lib, pkgs, ... }: 
{
  # https://mozilla.github.io/policy-templates
  programs.firefox.policies = {
    BlockAboutAddons = false;
    BlockAboutConfig = false;
    BlockAboutProfiles = false;
    BlockAboutSupport = false;
    CaptivePortal = true;
    DefaultDownloadDirectory = config.xdg.userDirs.downloads;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    SearchBar = false;
    ShowHomeButton = false;
    UseSystemPrintDialog = true;
    #WindowsSSO = false;
    #"3rdparty" = {};
  };
}
