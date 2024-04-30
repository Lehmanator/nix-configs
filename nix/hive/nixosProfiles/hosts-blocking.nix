{ inputs, config, lib, pkgs, ... }: {
  # Host-based ad & malware blocker. Also can block other optional types of hosts.
  networking.stevenblack = {
    enable = true;
    block = [ "social" ]; # "fakenews" "gambling" "porn"
  };
}
