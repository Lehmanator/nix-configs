{ config, lib, pkgs, ... }:
let
  mkLan = hn: lib.map (tld: "${hn}.${tld}") ["local" "lan"];
in
{
  networking.hosts = {
    # --- Home Network ---
    "192.168.1.1"   = mkLan "router";
    "192.168.1.2"   = mkLan "wyse";
    "192.168.1.6"   = mkLan "cheetah";
    "192.168.1.20"  = mkLan "nintendo";
    "192.168.1.30"  = mkLan "fw";
    "192.168.1.100" = mkLan "flame";

    # --- Remote Services ---
    "45.42.244.197" = [  "ollama.sea1"];
    "45.42.244.130" = ["api.kube.sea1"];

    # --- Tailscale Devices ---
    # TODO: Make parallel with home network
    # TODO: Reassign IP addresses in Tailscale admin UI
    # TODO: Better organization scheme
    "100.100.1.1"     = [ "cheetah.tailnet"];
    # "100.100.1.2"     = [   "flame.tailnet"];

    # "100.100.1.10"    = [ "fajita0.tailnet"];
    # "100.100.1.11"    = [ "fajita1.tailnet"];
    # "100.100.1.12"    = [   "taba8.tailnet"];

    # "100.100.1.1"     = ["router.tailnet"];
    # "100.100.1.10"    = [  "rpi3.tailnet"];
    # "100.100.1.20"    = [  "wyse.tailnet"];
    # "100.100.1.21"    = [   "aio.tailnet"];
    "100.100.245.120" = [    "wyse.tailnet"];
    "100.65.77.40"    = [      "fw.tailnet"];
    "100.64.49.109"   = [ "fajita0.tailnet"];
  };
}
