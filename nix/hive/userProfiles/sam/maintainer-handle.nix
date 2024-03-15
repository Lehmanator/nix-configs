{
  # TODO: Write homeModule with options for fields that cannot be deduced using
  # rest of home-manager environment/options & GPG keys.
  # TODO: Write script to create first nixpkgs commit.
  # This attrset must be added to nixpkgs repo in file: nixpkgs/maintainers/maintainer-list.nix
  # TODO: Write lib that automatically generates this data.
  # TODO: Write devShell that runs the command to create your first nixpkgs commit.
  lehmanator = {
    name = "Sam Lehman";
    email = "github@samlehman.dev";
    matrix = "@lehmanator:tchncs.de";
    github = "Lehmanator";
    githubId = "lehmanator"; # TODO: Retrieve
    keys = [
      {
        # TODO: Set GPG actual key
        longkeyid = "rsa4096/0x0123456789ABCDEF";
        fingerprint = "AAAA BBBB CCCC DDDD EEEE  FFFF 0000 1111 2222 3333";
      }
    ];
  };
}
