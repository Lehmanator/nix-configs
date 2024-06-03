{ lib, ... }: {
  # TODO: Compare `services.earlyoom` & `systemd.oom`
  services.earlyoom = {
      enable = true;

      # Note: Sets `services.systembus-notify.enable = true`
      #  Disable on systems where multiple users can login simultaneously
      #  - May allow other users to DoS your session with notification spam.
      #  Can we assume that for personal computers this will always hold true?
      #  - Shared desktop with SSH access?
      enableNotifications = lib.mkDefault true;
  };
}
