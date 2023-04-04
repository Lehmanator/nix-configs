{
  self,
  inputs,
  system,
  host, userPrimary,
  config, lib, pkgs,
  ...
}:
let
  # TODO: Randomize & actually use
  figs = [
    "nancyj-underlined" "nvscript" "jazmine" "o8" "ogre"  "puffy" 
    "rectangles"        "rev"      "roman"   "rowancap" 
    "rozzo"             "cursive"  "script"  "slant" 
    "standard"          "starwars" "thick"   "univers"  "whimsy"
  ];
in
{
  imports = [
    ./nix.nix
  ];

  # TODO: Abstract out sudo program
  environment.shellAliases = {
    # --- systemd ----------------
    ctl = "systemctl";
    sctl = "sudo systemctl";
    # --- Privileged Execution ---
    s = lib.mkIf config.security.sudo.enable "sudo";
    pk = "pkexec";
    # --- Nix --------------------
    n = "nix";
    nb = "nix build";
    build = "nix build";
    flake = "nix flake";
    profile = "nix profile";
    repl = "nix repl";
    run = "nix run";
    store = "nix store";
    # --- NixOS ------------------
    nboot = "sudo nixos-rebuild boot";
    nbuild = "sudo nixos-rebuild build";
    nbuilddry = "sudo nixos-rebuild dry-build";
    nbuildvm = "sudo nixos-rebuild build-vm";
    nbuildvmb = "sudo nixos-rebuild build-vm-with-bootloader";
    ndry = "sudo nixos-rebuild dry-activate";
    nswitch = "sudo nixos-rebuild switch";
    nswitchdry = "sudo nixos-rebuild switch";
    ntest = "sudo nixos-rebuild test";
    nupdate = "sudo nixos-rebuild switch --upgrade";
  };

  # --- System Info --------------
  environment.systemPackages = [ pkgs.figlet ];
  system.activationScripts.hostInfo = {
    # TODO: Change per system type
    text = ''
      ${pkgs.figlet}/bin/figlet -cf o8 "NixOS: ${config.networking.hostName}"
      echo "successfully activated system: ${config.networking.hostName}"
    '';
    #deps = [ pkgs.figlet ];
  };
}
