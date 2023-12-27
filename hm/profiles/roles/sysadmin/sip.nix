{ config, pkgs, ... }: {
  home.packages = [
    pkgs.sipp # The SIPp testing tool
    pkgs.sipsak # SIP Swiss army knife
    pkgs.siproxd # A masquerading SIP Proxy Server
    pkgs.sipexer # Modern and flexible SIP CLI tool
    pkgs.sipcalc # Advanced console ip subnet calculator
    pkgs.sipwitch # Secure peer-to-peer VoIP server that uses the SIP protocol
    pkgs.sipvicious # Set of tools to audit SIP based VoIP systems
    pkgs.twinkle # A SIP-based VoIP client
    pkgs.liblinphone # Library for SIP calls and instant messaging
    pkgs.libexosip # Library that hides the complexity of using the SIP protocol
    pkgs.baresip # A modular SIP User-Agent with audio and video support
    pkgs.libosip # The GNU oSIP library, an implementation of the Session Initiation Protocol (SIP)
    pkgs.spandsp3 # A portable and modular SIP User-Agent with audio and video support
    pkgs.sngrep # A tool for displaying SIP calls message flows from terminal
    pkgs.kamailio # Fast and flexible SIP server, proxy, SBC, and load balancer
    pkgs.pidginPackages.pidgin-sipe # SIPE plugin for Pidgin IM
    pkgs.sofia_sip # Open-source SIP User-Agent library, compliant with the IETF RFC3261 specification
    pkgs.linphone # Open source SIP phone for voice/video calls and instant messaging
    pkgs.libre # A library for real-time communications with async IO support and a complete SIP stack
    pkgs.osmo-sip-connector # This implements an interface between the MNCC (Mobile Network Call Control) interface of OsmoMSC (and also previously OsmoNITB) and SIP
    pkgs.pjsip # A multimedia communication library written in C, implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE
    pkgs.shadowsocks-v2ray-plugin # Yet another SIP003 plugin for shadowsocks, based on v2ray

  ];
}
