{ inputs
, config
, lib
, pkgs
, drives ? [ "Shared" ]
, ...
}:
let
  sambaHost = "PIW-DC01";
  flakeDir = "${config.xdg.configHome}/nixos";
  #shares-windows = ["C$" "D$" "E$"  ];
  #shares-min     = ["Shared"        ] ++ shares-windows;
  #shares-qb      = ["QBsCompanyFile"] ++ shares-min;
  #shares-hr      = ["Staff_Data"    ] ++ shares-qb;
  #shares-abmin   = ["ADMIN$" "NETLOGON" "PIWINE-SVR03" "print$" "SystemState$" "SYSVOL"] ++ shares-hr;
  #shares-all     = [ "ADMIN$" "C$" "Company Shared Data" "D$" "E$" "NETLOGON" "PIWINE-SVR03" "print$" "QBsCompanyFile" "Shared" "Staff_Data" "SystemState$" "SYSVOL" ];
in
{
  #home.packages = [ pkgs.cifs-utils ];
  systemd.user.automounts = lib.attrsets.recursiveMerge lib.lists.map
    (name: {
      "samba-piwc-${name}" = {
        Unit = {
          Description = "Samba Automount: PIWC - ${name}";
          SourcePath = "${flakeDir}/users/${config.home.username}/roles/common/drives.nix";
        };
        Automount = { };
      };
    })
    drives;

  systemd.user.mounts = lib.attrsets.recursiveMerge lib.lists.map
    (name: {
      "samba-piwc-${name}" = {
        Unit = {
          Description = "Samba Mount: PIWC - ${name}";
          After = "network-online.target";
          SourcePath = "${flakeDir}/users/${config.home.username}/roles/common/drives.nix";
        };
        Mount = {
          Type = "cifs";
          What = "//${sambaHost}/${name}";
          Where = "/run/media/${config.home.username}/PIWC-${name}";
          Options = [
            "rw"
            #"uid=${config.home.username}"
            "uid=1000"
            "gid=100"
            "credentials=${config.sops.secrets.samba-piwc-share-public.path}" #${credsDir}/samba-piwc-${name}.cred" #"/etc/samba/private/piwc-public.cred"
            "iocharset=utf8"
            "file_mode=0700" # User unit: "file_mode=700", System unit: "file_mode=0644"
            "dir_mode=0755" # User unit:  "dir_mode=700", System unit:  "dir_mode=0755"
          ];
        };
      };
    })
    drives;

  #systemd.user.automounts = {
  #  shared = {
  #    Unit = {
  #      Description = "Automount: PIWC Samba Share - Public ";
  #      #Documentation = ["man:piwc-share-public(1)"];
  #      SourcePath = "${flakeDir}/user/sam/roles/common/drives.nix"; # Path to config file unit generated from.
  #    };
  #    Automount = {
  #    };
  #  };
  #  staff-data = {
  #    Unit = {
  #      Description = "Automount: PIWC Samba Share - Staff Data ";
  #      SourcePath = "${flakeDir}/user/sam/roles/common/drives.nix"; # Path to config file unit generated from.
  #    };
  #    Automount = {
  #    };
  #  };
  #};
  #systemd.user.mounts = {
  #  shared = {
  #    Unit = {
  #      Description = "Mount: PIWC Samba Share - Public ";
  #      After = "network-online.target";
  #      SourcePath = "${flakeDir}/user/sam/roles/common/drives.nix"; # Path to config file unit generated from.
  #    };
  #    Mount = {
  #      Type = "cifs";
  #      What = "//PIW-DC01/Shared";
  #      Where = "/run/media/${config.home.username}/PIWC-Public";
  #      Options = mkUserMountOptions "public";
  #    };
  #  };
  #  staff-data = {
  #    Unit = {
  #      Description = "Mount: PIWC Samba Share - Staff Data ";
  #      SourcePath = "${flakeDir}/user/sam/roles/common/drives.nix"; # Path to config file unit generated from.
  #    };
  #    Mount = {
  #    };
  #  };
  #};
}
