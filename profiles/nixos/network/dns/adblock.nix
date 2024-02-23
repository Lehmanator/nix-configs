{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Host-based ad & malware blocker. Also can block other optional types of hosts.
  networking.stevenblack = {
    enable = true;
    block = [
      #"fakenews"
      #"gambling"
      #"porn"
      #"social"
    ];
  };

}
