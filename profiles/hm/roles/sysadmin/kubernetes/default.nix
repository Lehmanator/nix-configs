{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # TODO: Reorganize this file by splitting into categories.
  imports = [ ./security.nix ];
  # TODO: Separate into Kubernetes developer & administrator
  home.packages = with pkgs; [ kubelogin kubeadm kubectl k9s ];
  # TODO: Each cluster specified in separate `.nix` files, each appending their config to this env var.
  # TODO: Figure out if Nix's module merging can handle colon-separated strings.
  # TODO: Consider `XDG_DATA_HOME` vs `XDG_CONFIG_HOME` (possible to prevent secret auth data from being stored in `~/.config`?
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
        noIcons = false; # TODO: Pass global style var set in home-manager to determine icon presence
        logger = {
          tail = 200;
          buffer = 1000;
          sinceSeconds = 600;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
        currentContext = "sea1";
        currentCluster = "sea1";
        clusters = {
          sea1 = {
            namespace.active = "u-sam";
            namespace.favorites = "u-sam";
            view.active = "po";
            #featureGates.nodeShell = false;
            shellPod = {
              #image = "";  # Pod image to use
              namespace = "u-sam";
              limits.cpu = "100m";
              limits.memory = "100Mi";
            };
            #portForwardAddress = "1.2.3.4";
          };
          eri1 = {
            featureGates.nodeShell = true;
            namespace.active = "all";
            namespace.favorites = [ "all" "kube-system" "default" "testing" "prod" ];
          };
          piwc1 = {
            featureGates.nodeShell = true;
            namespace.active = "all";
            namespace.favorites = [ "all" "kube-system" "default" "testing" "prod" ];
          };
          piwc-azure = {
            featureGates.nodeShell = false;
            namespace.active = "all";
            namespace.favorites = [ "all" "kube-system" "default" "testing" "prod" ];
          };
        };
      };
    };
    # https://k9scli.io/topics/skins/
    #skins = {
    #  k9s = {
    #  };
    #};
  };

  # TODO: Write shell command thru Nix config in home-manager
  #pods() {
  #  : | command='kubectl get pods --all-namespaces' fzf \
  #    --info=inline --layout=reverse --header-lines=1 \
  #    --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
  #    --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
  #    --bind 'start:reload:$command' \
  #    --bind 'ctrl-r:reload:$command' \
  #    --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
  #    --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
  #    --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
  #    --preview-window up:follow \
  #    --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
  #}
}
