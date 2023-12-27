{ 
  inputs,
  lib, pkgs,
  ...
}:
let
  # TODO: Move to ./libs
  # TODO: Write lib to convert into host attrset
  # TODO: Use provided data to fill in missing gaps
  mkMachine = machineOverrides: lib.recursiveUpdate ({
    arch = "x86_64"; os = "linux"; ostype = "nixos"; system = "${arch}-${os}";
    hardware = { 
      cpu = { arch = "x86_64"; oem = "intel"; gen = "12"; class = "laptop"; year = null; };
      gpu = null;
      tpu = null;
      radios = { wifi = true; bluetooth = true; ir-receive = false; ir-send = false; };
      camera = { primary = "usb"; secondary = null; };
      displays = { primary = "external"; secondary = "external"; tertiary = "usb"; };
      
      formFactor = "desktop";
    };
    ips = {};
    modules = [];
    users = [];
  } machineOverrides);

  ostypes = {
    android = [
      "aosp"
      "calyxos"
      "divestos"
      "grapheneos"
      "eos"
      "lineageos"
      "oxygen"
      "paranoid"
      "pixel"
      "samsung"
      "termux"
    ];
    bsd = [
    ];
    linux = [
      "nixos"
      "arch"
      "debian" "ubuntu" "popos"
      "endlessos"
      "fedora" "silverblue"
      "gnomeos"
    ];
    mac = [ "darwin" ];
    windows = [ "wsl" ];
  };

  default = rec {
    arch = "x86_64";
    os = "linux";
    ostype = "nixos";
    system = "${arch}-${os}";
    ips = { };
    modules = [];
    users = [ ];
  };

in
{
  fw = rec {
    arch = "x86_64";
    os = "linux";
    ostype = "nixos";
    system = "${arch}-${os}";
    
    ips = {
      home = "192.168.1.200";
      work = "192.168.1.200";
      isle = "192.168.1.200";
      #isle = "104.28.245.64";
    };

    modules = [
      inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ];
  };

  wyse = lib.recursiveUpdate (defaults {
    
  });
}
