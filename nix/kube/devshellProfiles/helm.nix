{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [ ];
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
      category = "Helm";
      name = "helm-repo-update";
      help = "Update Helm repositories";
      command = "${lib.getExe pkgs.kubernetes-helm} repo update";
    }
    {
      category = "Management";
      name = "k9s";
      help = "Interactive TUI for kubectl";
      command = "${lib.getExe pkgs.k9s}";
    }
  ];
}
