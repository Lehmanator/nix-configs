{ inputs, self, hostsDir, ... }@importArgs:
{ host, system ? "x86_64-linux", mobile ? false, ... }@sysArgs:
let
  lehmanatorSystem = import ./lehmanatorSystem.nix importArgs;
  inherit (inputs.nixos.lib) hasSuffix removeSuffix optionals;
  host = removeSuffix "-minimal" sysArgs.host;
  hostEntry = hostsDir + "/${host}/${if hasSuffix "-minimal" sysArgs.host then "minimal" else "default"}.nix";

  specialArgsDefault = {
    inherit inputs;
    device = if sysArgs ? "device" then sysArgs.device else "uefi";
    user = "sam";
  };

  # Modules to be imported for mobile NixOS hosts
  modules-mobile = [
    { _module.args = specialArgsDefault; }
    (import "${inputs.mobile-nixos}/lib/configuration.nix" { device = sysArgs.device or "oneplus-fajita"; })
    inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
  ];
in
lehmanatorSystem rec {
  system = if (sysArgs ? mobile) && sysArgs.mobile then "aarch64-linux" else sysArgs.system or "x86_64-linux";
  modules = (sysArgs.modules or []) ++ (optionals mobile modules-mobile) ++ [hostEntry];
  specialArgs = specialArgsDefault // {
    
    # Instantiate all instances of nixpkgs in flake.nix to avoid creating new nixpkgs instances
    # for every `import nixpkgs` call within submodules/subflakes. Saves time & RAM.
    #  See:
    #  - https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
    #  - https://nixos-and-flakes.thiscute.world/nixpkgs/multiple-nixpkgs
    pkgs-stable       = import inputs.nixpkgs-stable       { inherit system; config.allowUnfree = true; };
    pkgs-unstable     = import inputs.nixpkgs-unstable     { inherit system; config.allowUnfree = true; };
    pkgs-master       = import inputs.nixpkgs-master       { inherit system; config.allowUnfree = true; };
    pkgs-staging      = import inputs.nixpkgs-staging      { inherit system; config.allowUnfree = true; };
    pkgs-staging-next = import inputs.nixpkgs-staging-next { inherit system; config.allowUnfree = true; };
  };
}
