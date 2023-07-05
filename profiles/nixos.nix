{ self
, inputs
, system
, host
, userPrimary
, config
, lib
, pkgs
, ...
}:
# TODO: Move all config that isn't NixOS-specific stuff to common file
{
  imports = [
    ./nix.nix
  ];

  # --- Nix CLI Settings -----------------------------------
  nix.settings.extra-experimental-features = [
    "auto-allocate-uids"
    "cgroups"
    #"dynamic-derivations" # After Nix v2.16.0
    "ca-derivations"
  ];

  # --- Finding Libraries ----------------------------------
  environment.systemPackages = with inputs.nix-alien.packages.${system}; [ nix-alien ];
  nixpkgs.overlays = [ inputs.nix-alien.overlays.default ];
  programs.nix-ld.enable = true;

  # --- Shell Environment ----------------------------------
  #nix.nixPath = [ "nixos=${inputs.nixos}" ];  #"nixos=${inputs.nixpkgs}"
  nix.nixPath = [ "nixos=/etc/nix/inputs/nixos:nixpkgs=/etc/nix/inputs/nixpkgs:home-manager=/etc/nix/inputs/home-manager" ];
  nix.registry = {
    nixos.flake = inputs.nixos;
    nixpkgs.flake = inputs.nixpkgs;
    home-manager.flake = inputs.home;
  };
  # Place flake source in /etc/nixos
  # TODO: Convert to divnix/hive first
  #etc.nixos.source = inputs.self;
  environment.etc."nix/inputs/nixos".source        = inputs.nixos.outPath;
  environment.etc."nix/inputs/home-manager".source = inputs.home.outPath;
  environment.shellAliases = let
    sudoProgram = with config.security; if doas.enable then "doas" else if please.enable then "please" else "sudo";
    flakeDir = "~/.config/nixos";
  in rec {
    # --- systemd ----------------
    ctl = "systemctl";
    sctl = "${sudoProgram} ${ctl}";

    # --- Privileged Execution ---
    s = sudoProgram;
    pk = lib.mkIf config.security.polkit.enable "pkexec";

    # --- NixOS ------------------
    nrb        = "${sudoProgram} nixos-rebuild";
    nboot      = "${nrb} boot";
    nbuild     = "${nrb} build";
    nbuilddry  = "${nrb} dry-build";
    nbuildvm   = "${nrb} build-vm";
    nbuildvmb  = "${nrb} build-vm-with-bootloader";
    ndry       = "${nrb} dry-activate";
    nswitch    = "${nrb} switch";
    nswitchdry = "${nrb} switch";
    ntest      = "${nrb} test";
    nupdate    = "${nrb} switch --upgrade";
    update     = "${cfgd} && l && git status && nix flake update --commit-lock-file && ${nrb} switch --upgrade-all";
    cfgd       = "cd ${flakeDir}";
  };

  # --- System Activation Info -----------------------------
  # TODO: Show flake inputs diff
  system.activationScripts = let
    # Figlet styles
    # TODO: Randomize & actually use
    favFig = "o8";
    figs = [
      "nancyj-underlined"
      "nvscript"
      "jazmine"
      "o8"
      "ogre"
      "puffy"
      "rectangles"
      "rev"
      "roman"
      "rowancap"
      "rozzo"
      "cursive"
      "script"
      "slant"
      "standard"
      "starwars"
      "thick"
      "univers"
      "whimsy"
    ];
    fig = favFig;
  in {
    # TODO: Calculate length of config.networking.hostName & fix box
    update-begin.text = let
      repoHost = "github.com";
      repoUser = "PresqueIsleWineDev";
      repoProj = "nix-configs";
    in ''
      echo ""
      echo "+-- System -----------------------------------------------+"
      echo "| Type: NixOS                                             |"
      echo "| Host: ${config.networking.hostName}                                                |"
      echo "| Date: $(date +%c)                  |"
      echo "| Repo: https://${repoHost}/${repoUser}/${repoProj} |"
      echo "+---------------------------------------------------------+"
      #echo "| Host: fw                                                                          |"
      echo "System: Activating ${config.networking.hostName}..."
    '';

    # TODO: Change per system type
    update-hostInfo.text = ''
      ${pkgs.figlet}/bin/figlet -cf ${fig} "NixOS: ${config.networking.hostName}"
      echo "NIX_PATH:"
      echo "$NIX_PATH" | tr ':' '\n'
      echo "nix registry list"
      nix registry list
    '';

    # TODO: Equivalent for home-manager?
    # TODO: Use system Nix CLI package
    # TODO: Write last diff to file?
    #${pkgs.nixUnstable}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
    update-diff.text = ''
      echo "System: diff-closures = "
      if [[ -e /run/current-system ]]; then
        ${config.nix.package}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
      fi
      echo "----------------------"
    '';
    update-index.text = ''
      # FIXME: Locks up whole system while running & takes too long to run on each rebuild.
      # TODO: Create systemd service + timer instead?
      #echo "System: Indexing files with nix-index..."
      #${pkgs.nix-index}/bin/nix-index && \
      #echo "System: Updated file index."
    '';
    update-end.text = ''
      echo "System: Activated ${config.networking.hostName}.";
      echo "----------------------------------------------------------"
      echo ""
    '';

    update-begin.deps    = [];
    update-hostInfo.deps = [ "update-begin" ];
    update-diff.deps     = [ "update-begin" "update-hostInfo" ];
    update-index.deps    = [ "update-begin" "update-hostInfo" "update-diff" ];
    update-end.deps      = [ "update-begin" "update-hostInfo" "update-diff" "update-index" ];
  };

}
