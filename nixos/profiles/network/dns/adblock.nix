{ lib, ... }: {
  # Host-based ad & malware blocker. Also can block other optional types of hosts.
  networking.stevenblack = {
    enable = lib.mkDefault false;
    # block = [ "fakenews" "gambling" "porn" "social" ];
  };
}
