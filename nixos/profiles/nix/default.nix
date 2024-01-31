{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./activation-script.nix
    ./cachix.nix
    ./shell.nix

    #../../common/nix
    #../../linux/nix

    #./ssh-serve-store.nix
  ];

  #nix = { };

  environment = {
    extraOutputsToInstall = ["bin"]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    shellAliases = {
      nix-closure-list = "nix-store -qR `which $1`"; # TODO: Figure out how to allow
      nix-closure-tree = "nix-store -q --tree `which $1`"; # arg not at end of alias
      nix-dependencies = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";
    };
  };
}
