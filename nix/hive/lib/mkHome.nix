{ inputs, cell, }:
let
  # Found here: https://github.com/GTrunSec/hivebus/blob/e9314e4f8537d61de4567697994f84203d244f56/nix/hive/cells/hosts/lib.nix
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.nixpkgs.stdenv) isDarwin isLinux;
  # nixpkgs = inputs.nixpkgs.appendOverlays ([] ++ cell.overlays.desktop);
  # inherit nixpkgs;
in
user: host: shell: {
  imports = [
    ({ pkgs, ... }: {
      home-manager.users.${user} = {
        inherit (cell.homeConfigurations."${host}") imports;
        home.stateVersion =
          if isDarwin then
            cell.darwinConfigurations.${host}.bee.pkgs.lib.trivial.release
          else
            "23.05";
      };
      users.users.${user} = {
        shell = pkgs."${shell}";
        home = if isDarwin then "/Users/${user}" else "/home/${user}";
      };
      programs.${shell}.enable = true;
    })
  ] ++ l.optionals (shell == "zsh") [{
    environment.pathsToLink = [ "/share/zsh" ];
  }] ++ l.optionals isLinux [
    inputs.cells.users.nixosProfiles.${user}
  ]; # inputs.cells.users.userProfiles.${user}
}
