{ cell, config, lib, pkgs, ... }: {
  # TODO: Reorganize this file by splitting into categories.
  imports = [
    cell.homeProfiles.k9s
    cell.homeProfiles.helm
  ];

  # TODO: Each cluster specified in separate `.nix` files, each appending their config to this env var.
  # TODO: Figure out if Nix's module merging can handle colon-separated strings.
  # TODO: Consider `XDG_DATA_HOME` vs `XDG_CONFIG_HOME` (possible to prevent secret auth data from being stored in `~/.config`?
  programs.k9s = {
    settings.k9s = {
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
          namespace.favorites =
            [ "all" "kube-system" "default" "testing" "prod" ];
        };
      };
    };
    # https://k9scli.io/topics/skins/
    #skins = {
    #  k9s = {
    #  };
    #};
  };
}
