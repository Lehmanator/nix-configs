{ inputs
, config
, lib
, pkgs
, harden ? false
, ...
}:
let
  config-hardened = {
    general = {
      acl-fallback-policy = false;
      strict-dlna = true;
      allow-upload = false;
      allow-deletion = false;
      interface = "wg0"; # Wireguard-only peers? Allow ethernet connections?
    };
    Tracker.strict-sharing = true;
    Tracker3.strict-sharing = true;
  };
in
{
  imports = [
  ];

  # Enable Rygel UPnP media server
  # Also requires allowing UPnP connections in firewall.
  services.gnome.rygel.enable = true;

  # --- Network & Firewall -------------
  # Allow rygel through firewall
  # TODO: Also open TCP ports? Set Rygel port in config to be static?
  # TODO: Convert `iptables` command to `nft` equivalent
  networking.firewall = lib.mkIf config.services.gnome.rygel.enable {
    allowedUDPPorts = [ 1900 ];
    extraPackages = [ pkgs.conntrack_tools ];
    autoLoadConntrackHelpers = true;
    extraCommands = ''
      # TODO: Check which command is correct:
      nfct add helper ssdp inet udp    # Originally present
      nft ct add helper ssdp inet udp  # Attempted correction

      # --- Old ---
      iptables --verbose -I OUTPUT -t raw -p udp --dport 1900 -j CT --helper ssdp

      # --- New ---
      # TODO: Check if iptables-translate converted properly
      nft -I OUTPUT -t raw -p udp --dport 1900 -j CT --helper ssdp
    '';
  };

  # --- Config -------------------------
  # Default: `environment.etc."rygel.conf".source = "${pkgs.gnome.rygel}/etc/rygel.conf";` (set when `services.gnome.rygel.enable=true`)
  #
  # See:
  # - https://man.archlinux.org/man/rygel.conf.5
  # - `man rygel.conf.5`
  #
  # TODO: Consider setting some options in `~/.config/rygel.conf` in home-manager instead
  # TODO: Review & set more options specified in Rygel config docs
  # TODO: Merge with default config.
  #  1. Convert `${pkgs.gnome.rygel}/etc/rygel.conf` format from `ini` -> `nix`
  #  2. Create Nix attrset of override options
  #  3. Merge (`lib.attrset.recursiveUpdate origConfAttrs overrideConfAttrs`)
  #  4. Convert back to `ini`
  #  5. Set `environment.etc."rygel.conf".source` to new merged `ini` multiline string
  # TODO: Override defaults with options in `config-hardened` when `harden=true` passed as module arg.
  # TODO: Set `general.ipv6` according to if system IPv6 enabled.
  # TODO: Find other D-Bus programs that work with MPRIS and/or Rygel
  environment.etc."rygel.conf".source = lib.attrsets.recursiveUpdate (builtins.fromTOML (builtins.readFile "${pkgs.gnome.rygel}/etc/rygel.conf")) {
    general = {
      # Policy used if no access control provider found on D-Bus. true = allow access from every peer. false = deny all access. Default = true
      # TODO: Set to false, add D-Bus ACL provider if necessary. (PolicyKit?)
      acl-fallback-policy = true;

      allow-upload = false;
      allow-deletion = false;

      enable-transcoding = true;

      ipv6 = true;
      port = 0; # Port to run HTTP server on. 0 means dynamic
      #interface = "wg0"; # Semi-colon-separated list of the network interfaces rygel should listen on.
      strict-dlna = false; # Default=false. true: disables set of features that improve compatibility w/ many clients, but break standard conformance
    };
    Database.debug = false;
    GstMediaEngine.transcoders = "mp3;lpcm;mp2ts;wmv;acc;avc";
    MediaExport.enabled = true;
    MPRIS.enabled = true;
    Renderer.image-timeout = 15;
    Ruih.enabled = true;
    "org.gnome.UPnP.MediaServer2.Rhythmbox".enabled = false;
  };


}
