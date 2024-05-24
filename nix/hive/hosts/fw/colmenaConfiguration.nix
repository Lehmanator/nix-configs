{ inputs, cell, super, }: {
  inherit (super) bee;

  # https://colmena.cli.rs/unstable/reference/deployment.html
  deployment = {
    allowLocalDeployment = true;
    tags = [ "laptop" ];
    targetHost = "127.0.0.1";
  };
}
