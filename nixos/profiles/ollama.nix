{ inputs, pkgs, lib, ... }:
let gpu = false;
in {
  services.ollama = {
    enable = true;

    # TODO: Set to wireguard interface
    listenAddress = "45.42.244.197:11434";

    #environmentVariables = {
    #  HIP_VISIBLE_DEVICES = "0,1";
    #  OLLAMA_LLM_LIBRARY = lib.mkIf gpu "cpu";
    #  LD_LIBRARY_PATH = "${config.boot.kernelPackages.nvidiaPackages.production}/lib";
    #};
    #home = "%S/ollama";
    #models = "%S/ollama/models";
    #writablePaths = [ ];

    #package = pkgs.ollama.override rec {
    #  src = pkgs.fetchFromGitHub {
    #    owner = "rnbwdsh";
    #    repo = "ollama";
    #    rev = "b783746ee69d5076ce17a789593c25ef362d0e0f";
    #    hash = lib.fakeHash;
    #    fetchSubmodules = true;
    #  };
    #  patches = let
    #    preparePatch = patch: hash: pkgs.fetchpatch {
    #      url = "file://${src}/llm/patches/${patch}";
    #      inherit hash;
    #      stripLen = 1;
    #      extraPrefix = "llm/llama.cpp/";
    #    };
    #  in [
    #    (inputs.nixpkgs + "/pkgs/tools/misc/ollama/disable-git.patch")
    #    (preparePatch "03-load_exception.diff" "sha256-1DfNahFYYxqlx4E4pwMKQpL+XR0bibYnDFGt6dCL4TM=")
    #    #(preparePatch "04-locale.diff" "sha256-r5nHiP6yN/rQObRu2FZIPBKpKP9yByyZ6sSI2SKj6Do=")
    #  ];
    #};
  };
}
