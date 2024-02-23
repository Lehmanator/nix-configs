{
  inputs,
  config,
  lib,
  ...
}: {
  # https://github.com/nix-community/nixvim
  imports = [inputs.kubenix.nixosModules.kubenix];

  #docker = {
  #  #copyScript = pkgs.copy-docker-images.sh;
  #  export = [];
  #  registry.url = "";
  #  images = {
  #    name = {
  #      name = "";
  #      image = pkgs."";
  #      path = ":"
  #      registry = "";
  #      tag = "";
  #    };
  #  };
  #};
  kubenix.project = lib.mkDefault "kubenix";
  kubernetes = {
    enableHashedNames = lib.mkDefault false;
    generated = [];
    imports = [];
    kubeconfig = config.sops.secrets.kubeconfig.path;
    version = lib.mkDefault "1.27";
    namespace = lib.mkDefault "default";
    objects = [];
    resources = {};
    resourceOrder = lib.mkDefault ["CustomResourceDefinition" "Namespace"];
    api = {
      defaults = [
        #{ default={}; group=""; kind=""; propagate=true; resource=""; version=null; }
      ];
      definitiions = {};
      types = {
        name = {
          attrName = "";
          group = "";
          kind = "";
          name = "";
          version = "";
        };
      };
    };
    helm.releases = {
      #name = {
      #  apiVersions = [""];
      #  chart = pkgs."";
      #  includeCRDs = true;
      #  kubeVersion = "1.27";
      #  name = "";
      #  namespace = "";
      #  noHooks = false;
      #  objects = [];
      #  overrideNames = true;
      #  overrides = [];
      #  values = {};
      #};
    };

    customResources = [];
    customTypes = {
      helmchartconfig = {
        attrName = "helmchartconfig";
        kind = "HelmChartConfig";
        version = "v1";
        group = "helm.cattle.io";
        #module = {};
        #name = "";
        #description = "";
      };
    };
  };

  #test = {
  #  enable = lib.mkDefault true;
  #  description = "";
  #  name = "";
  #  script = ''
  #  '';
  #  assertions = [ { assertion=false; message=""; } ]; # Set assertion dynamically to some Nix expr that renders to a bool
  #};

  #testing = {
  #  args = {};
  #  common = [ {features=[]; options={};} ];
  #  doThrowError = true;
  #  docker = {
  #    copyScript = pkgs."";
  #    images = [pkgs.""];
  #    registryUrl = "";
  #  };
  #  driver.kubetest = {
  #    extraPackages = [];
  #    defaultHeader = ''
  #      import pytest
  #    '';
  #  };
  #  enabledTests = [""];
  #  name = "default";
  #  runtime.local.script = pkgs."";
  #  tests = [ { module = null; } ];;
  #  testByName = {};
  #};

  # k3s project supports automatic resource deployment of files in the dir:
  #  `/var/lib/rancher/k3s/server/manifests`
  # let's write `resultYAML` to an arbitrary file under `/etc`
  environment.etc."kubenix.yaml".source =
    lib.mkIf config.k3s.enable
    (inputs.kubenix.evalModules.x86_64-linux {
      module = {kubenix, ...}: {
        imports = [kubenix.modules.k8s];
        kubernetes.resources.pods.example.spec.containers.example.image = "nginx";
      };
    })
    .config
    .kubernetes
    .resultYAML;
  # now we can link our file into the appropriate directory
  # and k3s will handle the rest
  system.activationScripts.kubenix.text = lib.mkIf config.k3s.enable ''
    ln -sf /etc/kubenix.yaml /var/lib/rancher/k3s/server/manifests/kubenix.yaml
  '';

  sops.secrets.kubeconfig = {};

  home-manager.sharedModules = [
    inputs.kubenix.homemManagerModules.kubenix
    # --- OR ---
    #../../../hm/profiles/modules/kubenix.nix
  ];

  # TODO: Learn about `lib.extendModules`
}
