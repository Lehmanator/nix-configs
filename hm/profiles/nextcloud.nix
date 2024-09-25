{ inputs, config, lib, pkgs, ... }:
let
  packages = {
    # Initialize Nextcloud
    nextcloud-init = pkgs.writeScriptBin "nextcloud-init" ''
      #!/usr/bin/env bash

      # Pod name as first argument
      # TODO: Retrieve if missing
      pod="$1"; shift

      # Execute OCC commands to perform setup commands
      kubectl exec $pod -- su -s /bin/sh www-data -c "php occ db:add-missing-indices"
      kubectl exec $pod -- su -s /bin/sh www-data -c "php occ db:convert-filecache-bigint --no-interaction"
      kubectl exec $pod -- su -s /bin/sh www-data -c "php occ recognize:download-models"
      kubectl exec $pod -- su -s /bin/sh www-data -c "php occ recognize:recrawl"
      kubectl exec $pod -- su -s /bin/sh www-data -c "php occ stt_whisper:download-models large"

      # Also execute any commands supplied by user
      while [[ $# -lt 1 ]]; do
       kubectl exec $pod -- su -s /bin/sh www-data -c "php occ $1"
       shift
      done
    '';

      # Put Nextcloud in of maintenance mode
      nextcloud-maintain = pkgs.writeScriptBin "nextcloud-maintain" ''
        #!/usr/bin/env bash
  
        # Pod name as first argument
        # TODO: Retrieve if missing
        pod="$1"; shift
  
        kubectl exec $pod -- su -s /bin/sh www-data -c "php occ maintenance:mode --on"
      '';
  
      # Take Nextcloud out of maintenance mode
      nextcloud-up = pkgs.writeScriptBin "nextcloud-up" ''
        #!/usr/bin/env bash
  
        # Pod name as first argument
        # TODO: Retrieve if missing
        pod="$1"; shift
  
        kubectl exec $pod -- su -s /bin/sh www-data -c "php occ maintenance:mode --off"
      '';
  
      # Upgrade Nextcloud chart
      nextcloud-upgrade = pkgs.writeScriptBin "nextcloud-upgrade" ''
        #!/usr/bin/env bash
  
        # TODO: Flag to revert upon failure
        helm upgrade nextcloud nextcloud/nextcloud
        kubectl exec $pod -- su -s /bin/sh www-data -c "php occ upgrade"
      '';
      nextcloud-status = pkgs.writeScriptBin "nextcloud-status" ''
        #!/usr/bin/env bash
  
        # TODO: Flag to revert upon failure
        helm upgrade nextcloud nextcloud/nextcloud
        kubectl exec $pod -- su -s /bin/sh www-data -c "php occ status"
      '';
    # kubectl exec nextcloud-6867786886-hzpwp -- su -s /bin/sh www-data -c "php occ stt_whisper:download-models large"
  };
in
{

 # TODO: Command to update all apps
 # TODO: Command to backup apps before update
 # TODO: Command to update models, etc.
 # TODO: Command to run taggers, etc.
  home.packages = lib.mapAttrsToList (_: v: v) packages;
}
