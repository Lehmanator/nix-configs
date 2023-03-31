{
  config, lib, pkgs,
  ...
}:
let
  # See: https://nixos.wiki/wiki/Samba
  # Mounting:
  #  $ mkdir -p /mnt/samba/${SAMBA_SHARE_NAME}
  #  $ sudo mount.cifs -o sec=none //${SAMBA_HOST}/${SAMBA_SHARE_NAME} /mnt/samba/${SAMBA_SHARE_NAME}
in
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
  
  services.gvfs.enable = true;

  # Discovery of machines & shares may need this firewall rule
  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
}
