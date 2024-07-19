# OpenWRT Images

[OpenWRT](https://openwrt.org) is an embedded Linux distribution optimized for small routers & access points with minimal amounts of storage to work with.

## Docs

### Nix

OpenWRT & Routing:

- [NixOS Wiki: OpenWRT](https://nixos.wiki/wiki/OpenWRT)
- [NixOS Wiki: Router](https://nixos.wiki/wiki/Workgroup:Router)

Image Builders & Configuration Types for OpenWRT:

- [astro/nix-openwrt-imagebuilder](https://github.com/astro/nix-openwrt-imagebuilder)
- [liminix](https://gti.telent.net/dan/liminix) *not a flake*
- [dewclaw](https://git.eno.space/dewclaw.git/tree/openwrt) *not a flake*
- ~~[telent/nixwrt](https://github.com/telent/nixwrt) - OpenWRT configuration & image generator.~~ **Archived on March 14th, 2023.**

Generic Image Builders:

- [cleverca22/not-os](https://github.com/cleverca22/not-os) - OS generator based on NixOS. Produces a small (47 MB) read-only squashfs for a runit-based OS w/ support for IPXE & signed boot.

### OpenWRT

- [openwrt.org - Developer Guide: ImageBuilder frontends](https://openwrt.org/docs/guide-developer/imagebuilder_frontends)
- [autobuild helper tool](https://johannes.truschnigg.info/code/openwrt_autobuild/)

## Example Code

```(nix)
inputs = {
  nix-openwrt-imagebuilder = { url = "github:astro/nix-openwrt-imagebuilder"; };
  nix-environments         = { url = "github:nix-community/nix-environments"; };
  liminix   = { flake = false; url = "https://gti.telent.net/dan/liminix";    };
  dewclaw   = { flake = false; url = "https://git.eno.space/dewclaw.git";     };
};

# Adapted from: https://github.com/astro/nix-openwrt-imagebuilder
outputs = {
  self,
  nixpkgs,
  nix-environments,
  nix-openwrt-imagebuilder,
  liminix,
  dewclaw,
  ...
}@inputs: {

  # Pass outputs.apps from inputs.nix-openwrt-imagebuilder
  apps = {
    openwrt-generate-hashes     = nix-openwrt-imagebuilder.apps.generate-hashes;
    openwrt-generate-hashes-all = nix-openwrt-imagebuilder.apps.generate-all-hashes;
  };

  devShells.x86_64-linux = { inherit (nix-environments.devShells.x86_64-linux) openwrt openwrt-ci; };

  # Define configs here
  openwrtConfigurations = let
    profiles = nix-openwrt-imagebuilder.lib.profiles {inherit pkgs;};
  in {
    # TODO: Find profile names if they exist.
    archer-c7 = (profiles.identifyProfile "archer_c7")  // {};
    rt-ac56u  = (profiles.identifyProfile "asus_AC56u") // {
      disabledServices = ["dnsmasq"];

      # Add package to include in the image. i.e. packages you dont want to manually install later.
      packages = ["tcpdump"];

      # Include files in the images.
      #  to set UCI configuration, create a `uci-defaults` scripts as per official OpenWRT ImageBuilder recommendation.
      files = pkgs.runCommand "image-files" {} ''
        mkdir -p $out/etc/uci-defaults
        cat > $out/etc/uci-defaults/99-custom <<EOF
        uci -q batch << EOI
        set system.@system[0].hostname='testap'
        commit
        EOI
        EOF
      '';
    };
  };

  liminixConfigurations = {
    archer-c7 = { config, lib, pkgs, ... }: {};
    rt-ac56u  = {config, lib, pkgs}: {
      imports = builtins.map (module: inputs.liminix + "/modules/" + module + ".nix")["all-modules"];
    };
  };
  dewclawConfigurations = {
    archer-c7 = { config, lib, pkgs, ... }: {};
    rt-ac56u  = { config, lib, pkgs, ... }: {};
  };

  # Export config as buildable image package
  packages.x86_64-linux = {
    router-image-ac56u-openwrt = builtins.mapAttrs (n: v: nix-openwrt-imagebuilder.lib.build v) self.openwrtConfigurations;
    router-image-ac56u-liminix = builtins.mapAttrs (n: v: nix-openwrt-imagebuilder.lib.build v) self.liminixConfigurations;
    router-image-ac56u-dewclaw = builtins.mapAttrs (n: v: nix-openwrt-imagebuilder.lib.build v) self.dewclawConfigurations;
  };

};

```

## Devices

1. ASUS RT-AC56U
  CPU: Broadcomm BCM4708A
  RAM: 256 MB
  Radios:
  - 2.4 GHz: Broadcomm BCM43217 (Unidentified 2.4GHz amplifier x2 + PN: 98649e231)
  - 5.0 GHz: Broadcomm BCM4352 (Skyworks SE5003L 5GHz Power Amp x2) 

2. TP-Link Archer C7
  CPU: 
  RAM: 
  Radios:
  - 2.4 GHz: 
  - 5.0 GHz: 

## To-Dos

- [ ] Find architecture / name / codename of CPU in routers.
- [ ] Determine if possible to add proprietary drivers for working 5GHz band radios
- [ ] Tool to export current configuration?
