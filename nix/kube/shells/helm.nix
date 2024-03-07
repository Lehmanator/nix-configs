{ inputs, cell, }:
let
  lib = inputs.nixpkgs.lib // builtins;
  pkgs = inputs.nixpkgs;
in
inputs.std.lib.dev.mkShell {
  name = "Helm Shell";
  imports = [ inputs.std.std.devshellProfiles.default ];
  motd = lib.mkForce ''
    {200} Hello! Welcome to the Helm devShell! {reset}
  '';
  env = [ ];
  packages = with inputs.kubenix.packages.${pkgs.system}; [
    docs
    generate-istio
    generate-k8s
    (pkgs.wrapHelm pkgs.kubernetes-helm {
      plugins = [
        pkgs.kubernetes-helmPlugins.helm-cm-push
        pkgs.kubernetes-helmPlugins.helm-diff
        pkgs.kubernetes-helmPlugins.helm-git
        pkgs.kubernetes-helmPlugins.helm-s3
        pkgs.kubernetes-helmPlugins.helm-secrets
        pkgs.kubernetes-helmPlugins.helm-unittest
      ];
    })
    pkgs.kubectl
    pkgs.kubeadm
    pkgs.k9s
    pkgs.gitFull
    pkgs.onefetch
  ];
  devshell.startup = {
    aaa-begin = {
      deps = [ ];
      text = "echo 'Welcome to the Helm devShell!'";
    };
    onefetch = {
      deps = [ "aaa-begin" ];
      # --no-merges --no-bots
      text = ''
        ${lib.getExe pkgs.onefetch} \
          --no-color-palette \
          --email \
          --include-hidden \
          --number-of-file-churns 8 \
          --number-separator comma \
          --type programming markup prose data
      '';
    };
  };
  commands = [
    {
      category = "info";
      name = "onefetch";
      help = "display repository info";
      command = ''
        ${lib.getExe pkgs.onefetch} \
            --no-color-palette \
            --email \
            --include-hidden \
            --number-of-file-churns 8 \
            --number-separator comma \
            --type programming markup prose data
      '';
    }
    {
      category = "Management";
      name = "k9s";
      help = "Interactive TUI for kubectl";
      command = "${lib.getExe pkgs.k9s}";
    }
  ];
}
