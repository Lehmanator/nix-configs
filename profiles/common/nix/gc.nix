{
  lib,
  pkgs,
  ...
}: {
  nix = {
    gc = {
      automatic = true; # Collect garbage
      options = "--cores 1 --max-freed 100G --max-jobs 1 --timeout 30 --delete-older-than 30d"; # Limit garbage collection to 100GB using 1 concurrent job on 1 core, & 30 seconds of runtime
      dates = "weekly";
    };
    optimise.automatic = true; # Store optimizer
    settings = {
      auto-optimise-store = lib.mkDefault true; # Dedup store files
      min-free = lib.mkDefault 128000000;
      max-free = lib.mkDefault 1000000000;
      keep-derivations = lib.mkDefault true;
      keep-env-derivations = lib.mkDefault false;
      keep-going = lib.mkDefault false;
      keep-outputs = lib.mkDefault true;
      preallocate-contents = lib.mkDefault true;
    };
  };
}
