{ inputs , self
, config, lib, pkgs
, user ? "sam"
, system
, ...
}:
# TODO: Move all config that isn't NixOS-specific stuff to common file
{
  imports = [
    #inputs.nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
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
  # nix-alien -
  # nix-ld    - Patch foreign packages to include their libraries that otherwise cannot be found on NixOS.
  # TODO: Anything needed to integrate nix-alien, nix-alien-ld, & nix-ld with nix-index-database ?
  environment.systemPackages = [inputs.nix-alien.packages.${pkgs.stdenv.system}.nix-alien];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [   # Common set of libraries used by arbitrary packages.
    stdenv.cc.cc nspr               zlib
    alsa-lib     pipewire           at-spi2-atk        at-spi2-core       atk
    curl         expat              fuse3              glib               gdk-pixbuf      gtk3
    fontconfig   freetype           cairo              pango
    mesa         libGL              libdrm             libnotify          libpulseaudio   libappindicator-gtk3
    libuuid      libusb1            libxkbcommon
    systemd      dbus               cups               icu                openssl         nss
    xorg.libX11  xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor    xorg.libXdamage
    xorg.libXext xorg.libXfixes     xorg.libxcb        # X11 Libraries
    xorg.libXi   xorg.libXrandr     xorg.libXrender
    xorg.libXtst xorg.libxkbfile    xorg.libxshmfence
  ];

  # --- Finding Binaries -----------------------------------
  # Service that symlinks paths in the Nix store to their typical location in more conventional FHS Linux distros
  services.envfs.enable = true;

  # --- Shell Environment ----------------------------------
  #nix.nixPath = [ "nixos=${inputs.nixos}" ];  #"nixos=${inputs.nixpkgs}"
  nix.nixPath = ["nixos=/etc/nix/inputs/nixos:nixpkgs=/etc/nix/inputs/nixpkgs:home-manager=/etc/nix/inputs/home-manager"];
  nix.registry = {
    nixos.flake = inputs.nixos;
    nixpkgs.flake = inputs.nixpkgs;
    home-manager.flake = inputs.home;
  };
  # Place flake source in /etc/nixos
  # TODO: Convert to divnix/hive first
  #etc.nixos.source = inputs.self;
  environment.etc."nix/inputs/nixos".source = inputs.nixos.outPath;
  environment.etc."nix/inputs/home-manager".source = inputs.home.outPath;
  environment.shellAliases = let
    sudoProgram = with config.security;
      if doas.enable
      then "doas"
      else if please.enable
      then "please"
      else "sudo";
    flakeDir = "~/.config/nixos";
  in rec {
    # --- systemd ----------------
    ctl = "systemctl";
    sctl = "${sudoProgram} ${ctl}";

    # --- Privileged Execution ---
    s = sudoProgram;
    pk = lib.mkIf config.security.polkit.enable "pkexec";

    # --- NixOS ------------------
    # TODO: Generate `nixos-rebuild` subcommands automatically
    nrb = "${sudoProgram} nixos-rebuild";
    nboot = "${nrb} boot";
    nbuild = "${nrb} build";                        nos-build     = nbuild;
    nbuilddry = "${nrb} dry-build";                 dry-build     = nbuilddry;
    nbuildvm = "${nrb} build-vm";                   build-vm      = nbuildvm;
    nbuildvmb = "${nrb} build-vm-with-bootloader";  build-vm-boot = nbuildvmb;
    ndry = "${nrb} dry-activate";                   dry-activate  = ndry;
    nswitch = "${nrb} switch";                          switch    = nswitch;
    nswitchdry = "${nrb} switch";                   dry-switch    = nswitchdry;
    ntest = "${nrb} test";
    nupdate = "${nrb} switch --upgrade";                     nup  = nupdate;      upd   = nupdate;
    nupdateall = "${nrb} switch --upgrade-all";              nupa = nupdateall;   upda  = nupdateall;
    update = "${cfgd} && l && git status && ${flake-update-cwd} && ${nrb} switch --upgrade-all";
    flake-update-cwd = "nix flake update --commit-lock-file";                     flupc = flake-update-cwd;
    flake-update = "${cfgd} && ${flake-update-cwd}"; update-flake = flake-update; flup  = flake-update;
    flake-dir    = "cd ${flakeDir}";                    dir-flake = flake-dir;    flcd  = flake-dir; cfgd = flake-dir;
    flake-show   = "nix flake show";                   show-flake = flake-show;   flls  = flake-show;
  };

  # --- System Activation Info -----------------------------
  # TODO: Show flake inputs diff
  #system.activationScripts = let
  #  # Figlet styles
  #  # TODO: Randomize & actually use
  #  favFig = "o8";
  #  figs = [
  #    "nancyj-underlined"
  #    "nvscript"
  #    "jazmine"
  #    "o8"
  #    "ogre"
  #    "puffy"
  #    "rectangles"
  #    "rev"
  #    "roman"
  #    "rowancap"
  #    "rozzo"
  #    "cursive"
  #    "script"
  #    "slant"
  #    "standard"
  #    "starwars"
  #    "thick"
  #    "univers"
  #    "whimsy"
  #  ];
  #  fig = favFig;
  #in {
  #  # TODO: Calculate length of config.networking.hostName & fix box
  #  # TODO: Change per system type
  #  # TODO: Wrap table with border
  #  # TODO: Highlight syntax <system|global> <flake>:<inputName> <path|git+file|github>:<owner>/<repo> # <path> can have args like URL params.
  #  # TODO: Equivalent for home-manager?
  #  # TODO: Use system Nix CLI package
  #  # TODO: Write last diff to file?
  #  #${pkgs.nixUnstable}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
  #  # FIXME: nix-index: Locks up whole system while running & takes too long to run on each rebuild.
  #  # TODO: nix-index: Create systemd service + timer instead?
  #  update-end.text = let
  #    baseDirLog = "/var/log/nixos";
  #    diffLog = "${baseDirLog}/latest-package-diff.txt";
  #    repoHost = "github.com";
  #    repoUser = "PresqueIsleWineDev";
  #    repoProj = "nix-configs";
  #  in ''
  #    echo
  #    ${pkgs.figlet}/bin/figlet -cf ${fig} "NixOS: ${config.networking.hostName}"
  #    echo
  #    echo '╭──────────────────────────────────────────────────────────────────╮'
  #    echo '│                                                                  │'
  #    echo '│  ╭───System───────────────────────────────────────────────────╮  │'
  #    echo '│  │ Type: NixOS                                                │  │'
  #    echo "│  │ Host: ${config.networking.hostName}                                                   │  │"
  #    echo "│  │ Date: $(date +%c)                      │  │"
  #    echo "│  │ Repo: https://${repoHost}/${repoUser}/${repoProj}    │  │"
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    echo "│  [system] Activating system: ${config.networking.hostName}...                               │"
  #    echo '│  ╭───Nix─Path─────────────────────────────────────────────────╮  │'
  #    echo "$NIX_PATH" | tr ':' '\n' | tr '=' ' ' | column --table --output-separator ' │ ' --output-width 60 --table-column name=Input,width=20,right,trunc --table-column name=Path,wrap
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    echo '│  ╭───Nix─Registry─────────────────────────────────────────────╮  │'
  #    ${config.nix.package}/bin/nix registry list | column --table --output-separator ' │ ' --output-width 60 --table-column name=Scope,width=10,trunc --table-column name=Input --table-column name=Path,wrap
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    if [[ -e /run/current-system ]]; then
  #    echo '│  ╭───Nix─Closure─Diff─────────────────────────────────────────╮  │'
  #    echo '│  │  diff-closures = {                                         │  │'
  #    ${config.nix.package}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig" #> "${diffLog}"
  #    echo '│  │  }                                                         │  │'
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    fi
  #    echo '│  [system] Indexing files with nix-index...                       │'
  #    #${pkgs.nix-index}/bin/nix-index >/dev/null && \
  #    echo '│  [system] Updated file index.                                    │'
  #    echo '│  [system] Updating tldr cache...                                 │'
  #    #${pkgs.tealdeer}/bin/tldr --update >/dev/null
  #    echo '│  [system] Updated tldr cache.                                    │'
  #    echo "│  [system] Activated ${config.networking.hostName}.                                          │";
  #    echo '╰──────────────────────────────────────────────────────────────────╯'
  #    echo
  #  '';
  #  update-end.deps = [];
  #};
}
