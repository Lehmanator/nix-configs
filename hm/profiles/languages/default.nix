{ pkgs, ... }:
{
  # TODO: Use haumea loader?
  imports = [
    # ./android.nix
    ./bash.nix
    ./cue.nix
    ./docker.nix
    ./javascript.nix
    ./kubernetes.nix
    ./markdown.nix
    ./nickel.nix
    ./nix.nix
    ./nodejs.nix
    ./python.nix
    ./rust.nix
    ./yaml.nix
  ];

  home.packages = [
    pkgs.pkg-config
    pkgs.universal-ctags
    pkgs.vscode-langservers-extracted
    pkgs.vscode-extensions.vadimcn.vscode-lldb
  ];
}
