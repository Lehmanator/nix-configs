{ config, lib, pkgs
, rootless ? true
, user
, ...
}:
{
  # Enable CGroupsV2
  systemd = lib.mkIf rootless {
    enableUnifiedCgroupHierarchy = true;
    enableCgroupAccounting = true;
  };

  # Auto subuid / subgid range
  users.users.${user}.autoSubUidGidRange = true;

  # When disabled, unprivileged users will not be able to create new namespaces.
  # By default unprivileged user namespaces are disabled.
  # This option only works in a hardened profile.
  security.unprivilegedUsernsClone = true;

  # https://github.com/containerd/containerd/blob/main/docs/cri/config.md
  virtualisation.containerd = {
    enable = true;
    args = {};
    configFile = null;
    settings = {};
  };

  # See rke2 agent config options:
  # https://github.com/k3s-io/k3s/blob/master/pkg/agent/templates/templates.go#L16-L32

  # environment.sessionVariables = {
  #   HTTP_PROXY = "http://your-proxy.example.com:8888";
  #   HTTPS_PROXY = "https://your-proxy.example.com:8888";
  #   NO_PROXY = "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16";
  #   CONTAINERD_HTTP_PROXY = "http://your-proxy.example.com:8888";
  #   CONTAINERD_HTTPS_PROXY = "http://your-proxy.example.com:8888";
  #   CONTAINERD_NO_PROXY = "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16";
  #
  #   # Enable SELinux inside container runtimes
  #   #RKE2_SELINUX = "true";
  # };

  # Also see:
  # https://docs.rke2.io/reference/linux_agent_config
  # https://docs.rke2.io/reference/server_config

}
