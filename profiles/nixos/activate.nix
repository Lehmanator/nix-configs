{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

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
