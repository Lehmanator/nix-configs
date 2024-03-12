{ inputs, cell, }:
#cell.pops.pkgs.exports.default
{
  nixpkgs-master =
    #{ inputs, cell, }:
    import inputs.nixpkgs-master { inherit (inputs.nixpkgs) system; };
  nixpkgs-unstable =
    #{ inputs, cell, }:
    import inputs.nixpkgs-unstable { inherit (inputs.nixpkgs) system; };
  nixpkgs-stable =
    #{ inputs, cell, }:
    import inputs.nixpkgs-stable { inherit (inputs.nixpkgs) system; };
  nixpkgs-staging =
    #{ inputs, cell, }:
    import inputs.nixpkgs-staging { inherit (inputs.nixpkgs) system; };
  nixpkgs-staging-next =
    #{ inputs, cell, }:
    import inputs.nixpkgs-staging-next { inherit (inputs.nixpkgs) system; };
  nixpkgs-darwin =
    #{ inputs, cell, }:
    import inputs.nixpkgs-darwin { inherit (inputs.nixpkgs) system; };
  nixos-stable =
    #{ inputs, cell, }:
    import inputs.nixos-stable { inherit (inputs.nixpkgs) system; };
  nixos-unstable =
    #{ inputs, cell, }:
    import inputs.nixos-unstable { inherit (inputs.nixpkgs) system; };
}
