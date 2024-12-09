{ ... }:
{
  # TODO: Use haumea loader?
  imports = [
    # ./android.nix
    ./bash.nix
    ./markdown.nix
    ./nix.nix
    ./nodejs.nix
    ./python.nix
    ./rust.nix
  ];
}
