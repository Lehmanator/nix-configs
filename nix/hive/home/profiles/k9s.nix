{ config, lib, pkgs, ... }: {
  imports = [ ];

  home.sessionVariables.KUBECONFIG = "${config.xdg.configHome}/kube/config";

  # https://k9scli.io/
  # https://k9scli.io/topics/config/
  # https://github.com/derailed/k9s/tree/master
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        refreshRate = 5;
        maaConnRetry = 15;
        enableMouse = true;
        headless = true;
        crumbsless = true;
        readOnly = false;

        # TODO: Pass global style var set in home-manager to determine icon presence
        noIcons = false;

        logger = {
          tail = 200;
          buffer = 1000;
          sinceSeconds = 600;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
      };
    };
  };
}
